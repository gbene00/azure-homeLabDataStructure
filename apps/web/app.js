const FUNCTION_BASE_URL = "https://dp-function-100.azurewebsites.net";

window.addEventListener("DOMContentLoaded", () => {
  console.log("✅ app.js loaded (DOMContentLoaded)");

  const fileInput = document.getElementById("fileInput");
  const uploadBtn = document.getElementById("uploadBtn");
  const statusEl = document.getElementById("status");

  if (!fileInput || !uploadBtn || !statusEl) {
    console.error("❌ Missing DOM elements:", { fileInput, uploadBtn, statusEl });
    return;
  }

  function setStatus(msg) {
    statusEl.textContent = msg;
    console.log("STATUS:", msg);
  }

  async function getUploadUrl(filename) {
    console.log("➡️ Calling GetUploadUrl with:", filename);

    const res = await fetch(`${FUNCTION_BASE_URL}/api/upload-url`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ filename })
    });

    const text = await res.text();
    console.log("⬅️ GetUploadUrl response:", res.status, text);

    if (!res.ok) throw new Error(`GetUploadUrl failed: ${res.status} ${text}`);
    return JSON.parse(text);
  }

  async function uploadToBlob(uploadUrl, file) {
    console.log("➡️ Uploading to blob:", uploadUrl);

    const res = await fetch(uploadUrl, {
      method: "PUT",
      headers: {
        "x-ms-blob-type": "BlockBlob",
        "Content-Type": file.type || "application/octet-stream"
      },
      body: file
    });

    const text = await res.text();
    console.log("⬅️ Blob PUT response:", res.status, text);

    if (!res.ok) throw new Error(`Blob upload failed: ${res.status} ${text}`);
  }

  uploadBtn.addEventListener("click", async (e) => {
    e.preventDefault(); // extra safety
    console.log("🖱️ Upload clicked");

    const file = fileInput.files && fileInput.files[0];
    console.log("📄 Selected file:", file);

    if (!file) {
      setStatus("Select a file first.");
      return;
    }

    try {
      setStatus("Requesting upload URL...");
      const { uploadUrl, expiresUtc } = await getUploadUrl(file.name);

      setStatus(`Uploading... (SAS expires ${expiresUtc})`);
      await uploadToBlob(uploadUrl, file);

      setStatus("✅ Uploaded to raw-blob. Check processed-blob shortly.");
    } catch (err) {
      console.error("❌ Upload flow error:", err);
      setStatus(`❌ Error: ${err.message}`);
    }
  });
});

