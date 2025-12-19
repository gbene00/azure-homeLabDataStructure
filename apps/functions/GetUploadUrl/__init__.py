import json
import os
from datetime import datetime, timedelta, timezone

import azure.functions as func
from azure.storage.blob import BlobSasPermissions, generate_blob_sas, BlobServiceClient


def main(req: func.HttpRequest) -> func.HttpResponse:
    try:
        body = req.get_json()
        filename = body.get("filename")
        if not filename:
            return func.HttpResponse(
                json.dumps({"error": "Missing 'filename' in request body"}),
                status_code=400,
                mimetype="application/json",
            )

        storage_conn = os.environ.get("DATA_STORAGE_CONNECTION_STRING") or os.environ.get("AzureWebJobsStorage")
        account_name = os.environ.get("STORAGE_ACCOUNT")
        container_name = os.environ.get("RAW_CONTAINER", "raw-blob")

        if not storage_conn:
            return func.HttpResponse(
                json.dumps({"error": "AzureWebJobsStorage is not set"}),
                status_code=500,
                mimetype="application/json",
            )

        # Parse account key from connection string via BlobServiceClient
        bsc = BlobServiceClient.from_connection_string(storage_conn)
        # Access private attr is not ideal; better parse manually:
        # but for a homelab it's acceptable. We'll do a safe parse below.
        account_key = None
        for part in storage_conn.split(";"):
            if part.startswith("AccountKey="):
                account_key = part.split("=", 1)[1]
                break

        if not account_name:
            # If STORAGE_ACCOUNT isn't set, derive from connection string
            for part in storage_conn.split(";"):
                if part.startswith("AccountName="):
                    account_name = part.split("=", 1)[1]
                    break

        if not account_name or not account_key:
            return func.HttpResponse(
                json.dumps({"error": "Could not determine storage account name/key"}),
                status_code=500,
                mimetype="application/json",
            )

        expiry = datetime.now(timezone.utc) + timedelta(minutes=15)

        sas = generate_blob_sas(
            account_name=account_name,
            container_name=container_name,
            blob_name=filename,
            account_key=account_key,
            permission=BlobSasPermissions(create=True, write=True, add=True),
            expiry=expiry,
        )

        upload_url = f"https://{account_name}.blob.core.windows.net/{container_name}/{filename}?{sas}"

        return func.HttpResponse(
            json.dumps(
                {
                    "filename": filename,
                    "container": container_name,
                    "uploadUrl": upload_url,
                    "expiresUtc": expiry.isoformat(),
                }
            ),
            status_code=200,
            mimetype="application/json",
        )

    except ValueError:
        return func.HttpResponse(
            json.dumps({"error": "Invalid JSON body"}),
            status_code=400,
            mimetype="application/json",
        )
    except Exception as e:
        return func.HttpResponse(
            json.dumps({"error": str(e)}),
            status_code=500,
            mimetype="application/json",
        )