import json
import os
import time
from urllib.parse import urljoin

import azure.functions as func
import requests
from azure.storage.blob import BlobServiceClient


def main(inputBlob: func.InputStream) -> None:
    storage_conn = os.environ.get("DATA_STORAGE_CONNECTION_STRING") or os.environ.get("AzureWebJobsStorage")
    processed_container = os.environ.get("PROCESSED_CONTAINER", "processed-blob")

    docint_endpoint = os.environ.get("DOCINT_ENDPOINT")
    docint_key = os.environ.get("DOCINT_KEY")

    if not storage_conn:
        raise RuntimeError("AzureWebJobsStorage is not set")
    if not docint_endpoint or not docint_key:
        raise RuntimeError("DOCINT_ENDPOINT / DOCINT_KEY are not set")

    blob_name = inputBlob.name.split("/")[-1]  # just file name
    content = inputBlob.read()

    # Document Intelligence Read model (REST)
    # Endpoint format:
    # POST {endpoint}/formrecognizer/documentModels/prebuilt-read:analyze?api-version=2023-07-31
    analyze_path = "/formrecognizer/documentModels/prebuilt-read:analyze?api-version=2023-07-31"
    analyze_url = urljoin(docint_endpoint.rstrip("/") + "/", analyze_path.lstrip("/"))

    headers = {
        "Ocp-Apim-Subscription-Key": docint_key,
        "Content-Type": "application/octet-stream",
    }

    resp = requests.post(analyze_url, headers=headers, data=content)
    resp.raise_for_status()

    operation_location = resp.headers.get("operation-location")
    if not operation_location:
        raise RuntimeError("Missing operation-location header from Document Intelligence response")

    # Poll for result
    poll_headers = {"Ocp-Apim-Subscription-Key": docint_key}
    for _ in range(30):  # ~30 * 2s = 60s
        poll = requests.get(operation_location, headers=poll_headers)
        poll.raise_for_status()
        result = poll.json()
        status = result.get("status")
        if status in ("succeeded", "failed"):
            break
        time.sleep(2)

    if result.get("status") != "succeeded":
        raise RuntimeError(f"Document Intelligence analyze failed: {json.dumps(result)[:500]}")

    # Create a small structured output
    pages = result.get("analyzeResult", {}).get("pages", [])
    content_text = result.get("analyzeResult", {}).get("content", "")

    output = {
        "sourceBlob": blob_name,
        "pages": len(pages),
        "content": content_text,
    }

    # Upload JSON to processed container
    bsc = BlobServiceClient.from_connection_string(storage_conn)
    out_blob_name = f"{blob_name}.json"

    bsc.get_container_client(processed_container).upload_blob(
        name=out_blob_name,
        data=json.dumps(output, ensure_ascii=False, indent=2),
        overwrite=True,
        content_type="application/json",
    )