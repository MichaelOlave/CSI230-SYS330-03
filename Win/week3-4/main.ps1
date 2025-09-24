. "Win\week3-4\EventLogs.ps1"

Write-Output "Logon/Logoff Events:"
$logonLogs = Get-Logs(7)
$logonLogs | Format-Table -AutoSize

Write-Output "`nStartup/Shutdown Events:"
$startupShutdownLogs = Get-StartupShutdownLogs(7)
$startupShutdownLogs | Format-Table -AutoSize