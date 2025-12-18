const FUNCTION_BASE_URL = "https://dp-function-100.azurewebsites.net";

const fileInput = document.getElementById("fileInput");
const uploadBtn = document.getElementById("uploadBtn");
const statusEl = document.getElementById("status");

function setStatus(msg) {
  statusEl.textContent = msg;
}

async function getUploadUrl(filename) {
  const res = await fetch(`${FUNCTION_BASE_URL}/api/upload-url`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ filename })
  });

  if (!res.ok) {
    const text = await res.text();
    throw new Error(`GetUploadUrl failed: ${res.status} ${text}`);
  }

  return await res.json(); // expects { uploadUrl, ... }
}

async function uploadToBlob(uploadUrl, file) {
  const res = await fetch(uploadUrl, {
    method: "PUT",
    headers: {
      "x-ms-blob-type": "BlockBlob"
    },
    body: file
  });

  if (!res.ok) {
    const text = await res.text();
    throw new Error(`Blob upload failed: ${res.status} ${text}`);
  }
}

uploadBtn.addEventListener("click", async () => {
  const file = fileInput.files[0];
  if (!file) {
    setStatus("Select a file first.");
    return;
  }

  try {
    setStatus("Requesting upload URL...");

    const { uploadUrl, expiresUtc } = await getUploadUrl(file.name);

    setStatus(`Uploading to Blob... (expires ${expiresUtc})`);
    await uploadToBlob(uploadUrl, file);

    setStatus(
      "✅ Uploaded to raw-blob. Processing will run automatically.\n\n" +
      "Next: check processed-blob for <filename>.json"
    );
  } catch (err) {
    setStatus(` Error: ${err.message}`);
  }
});

await fetch(uploadUrl, {
  method: "PUT",
  headers: {
    "x-ms-blob-type": "BlockBlob",
    "Content-Type": file.type || "application/octet-stream"
  },
  body: file
});

