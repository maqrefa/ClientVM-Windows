# === CONFIGURASI ===
$ManagerIP = "192.168.1.16"
$ManagerPort = 1514
$AgentService = "wazuh"
$LogSource = "WazuhTest"
$LogName = "Application"

# === 1. Daftarkan Source Log (jika belum ada) ===
if (-not [System.Diagnostics.EventLog]::SourceExists($LogSource)) {
    New-EventLog -LogName $LogName -Source $LogSource
    Write-Host "Source log '$LogSource' berhasil didaftarkan."
} else {
    Write-Host "Source log '$LogSource' sudah ada."
}

# === 2. Kirim Log Dummy ===
Write-EventLog -LogName $LogName -Source $LogSource -EventID 1000 -EntryType Information -Message "Test log from agent"
Write-Host "Log dummy dikirim ke Event Viewer."

# === 3. Tes Koneksi ke Manager ===
$test = Test-NetConnection -ComputerName $ManagerIP -Port $ManagerPort
if ($test.TcpTestSucceeded) {
    Write-Host "Koneksi ke Wazuh Manager (${ManagerIP}:${ManagerPort}) berhasil."
} else {
    Write-Host "Gagal konek ke Wazuh Manager (${ManagerIP}:${ManagerPort}). Cek firewall dan IP."
}

# === 4. Cek dan Restart Service Agent ===
$service = Get-Service -Name $AgentService
if ($service.Status -ne "Running") {
    Start-Service -Name $AgentService
    Write-Host "Service '$AgentService' telah dijalankan."
} else {
    Restart-Service -Name $AgentService
    Write-Host "Service '$AgentService' direstart."
}

Write-Host "Done , or tunggu 1-2 min"

