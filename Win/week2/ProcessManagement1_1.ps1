(Get-Process | Where-Object { $_.Name -ilike "C*" })

(Get-Process | Where-Object { $_.Path -cnotlike "system32" })

$services = (Get-Service | Where-Object { $_.Status -eq " Stopped" } | Sort-Object)

$services | Export-Csv -Path ./week2/StoppedServices.csv

$braveProcess = Get-Process -Name brave -ErrorAction SilentlyContinue

if ($null -eq $braveProcess) {
    Start-Process "brave.exe" "https://www.champlain.edu"
    Write-Host "Started Brave and directed it to champlain.edu."
}
else {
    Stop-Process -Name brave -Force
    Write-Host "Stopped all running instances of Brave."
}
