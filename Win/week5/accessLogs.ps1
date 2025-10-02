$A = Get-ChildItem -Path C:\xampp\apache\logs\*.log | Select-String -AllMatches 'error'

$A[-5..-1]

$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 '

$regex = [regex] '(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)'

$ipsUnorganized = $regex.Matches($notfounds)

$ips = @()
for ($i = 0; $i -lt $ipsUnorganized.Count; $i++) {
    $ips += [PSCustomObject]@{
        "IP" = $ipsUnorganized[$i].Value;
    }
}
$ipsoftens = $ips | Where-Object { $_.IP -ilike '10.*' }

$counts = $ipsoftens | Group-Object IP

$counts | Select-Object Count, Name
