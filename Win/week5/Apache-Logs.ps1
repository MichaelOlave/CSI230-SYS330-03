function Get-Ips($page, $code, $browser) {
    $logs = Get-Content C:\xampp\apache\logs\access.log | Select-String $code | Select-String $page | Select-String $browser
    $ips = $logs -replace '.*?(\d+\.\d+\.\d+\.\d+).*', '$1' | Select-Object -Unique
    return $ips
}

function ApacheLogs1 {
    $logsNotformatted = Get-Content C:\xampp\apache\logs\access.log
    $tableRecords = @();

    for ($i = 0; $i -lt $logsNotformatted.Length; $i++) {
        $words = $logsNotformatted[$i].Split(" ");
        $tableRecords += [PSCustomObject]@{
            "IP"       = $words[0];
            "Time"     = $words[3].Trim('[');
            "Method"   = $words[5].Trim('"');
            "Page"     = $words[6];
            "Protocol" = $words[7];
            "Response" = $words[8];
            "Referrer" = $words[9];
            "Client"   = $words[11..($words.Count)];
        }
    }
    return $tableRecords | Where-Object { $_.IP -ilike "10.*" }
}

$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap
