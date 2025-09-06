Write-Host "Part 1"
Write-Host "#1 - IPv4"
(Get-NetIpAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet" }).IPAddress
Write-Host "#2 - IPv4 Prefixlength"
(Get-NetIpAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet" }).PrefixLength
Write-Host "#3-4 - Classes of Win32 library that starts with net - Alphabetically"
Get-WmiObject -list | Where-Object { $_.Name -ilike "Win32_Net*" } | Sort-Object 
Write-Host "#5-6 - DHCP Server IP - Hidden table headers"
Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=True" | select DHCPServer | Format-Table -HideTableHeaders
Write-Host "#7 - DNS Server IP for Ethernet interface"
(Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet" }).ServerAddresses[0]
Write-Host "Part 2"
Write-Host "#8 - ListFilesInWorkingDir.ps1"
& "C:\Users\WindowsXI\Desktop\CSI230\week2\ListFilesInWorkingDir.ps1"
Write-Host "#9 - CreateDir.ps1"
& "C:\Users\WindowsXI\Desktop\CSI230\week2\CreateDir.ps1"
Write-Host "#10 - ListAndExport.ps1"
& "C:\Users\WindowsXI\Desktop\CSI230\week2\ListAndExport.ps1"
Write-Host "#11 - ConvertOutToLog.ps1"
& "C:\Users\WindowsXI\Desktop\CSI230\week2\ConvertOutToLog.ps1"