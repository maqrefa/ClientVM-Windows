# === Lokasi folder yang dimonitor oleh FIM ===
$targetPath = "C:\Users\Public\fim-test"

# === 1. Buat folder dan file dummy ===
New-Item -ItemType Directory -Path $targetPath -Force | Out-Null
New-Item -ItemType File -Path "$targetPath\created.txt" -Value "Initial content" | Out-Null
Write-Host "File created: created.txt"

# === 2. Ubah isi file ===
Set-Content -Path "$targetPath\created.txt" -Value "Modified content"
Write-Host "File modified: created.txt"

# === 3. Tambah file baru ===
New-Item -ItemType File -Path "$targetPath\newfile.txt" -Value "This is a new file" | Out-Null
Write-Host "File created: newfile.txt"

# === 4. Hapus file ===
Remove-Item "$targetPath\newfile.txt"
Write-Host "File deleted: newfile.txt"

# === 5. Rename file ===
Rename-Item "$targetPath\created.txt" "$targetPath\renamed.txt"
Write-Host "File renamed: created.txt → renamed.txt"

# === 6. Loop: Buat dan hapus 10 file ===
for ($i = 1; $i -le 10; $i++) {
    $fileName = "$targetPath\file$i.txt"
    New-Item -ItemType File -Path $fileName -Value "File number $i" | Out-Null
    Write-Host "File created: file$i.txt"

    # Simulasi delay jika perlu
    Start-Sleep -Milliseconds 500

    Remove-Item $fileName
    Write-Host "File deleted: file$i.txt"
}

Write-Host "Done, wait 2 min"
