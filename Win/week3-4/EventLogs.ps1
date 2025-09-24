# $Eventlogs = Get-EventLog -LogName System -source Microsoft-Windows-WinLogon

# $logsTable = @()

# for ($i = 0; $i -lt $Eventlogs.count; $i++) {
#     $eventT = ''
#     if ($Eventlogs[$i].EventID -eq 7001) { $eventT = 'Logon' }
#     if ($Eventlogs[$i].EventID -eq 7002) { $eventT = 'Logoff' }

#     $user = $Eventlogs[$i].ReplacementStrings[1]
#     $userName = New-Object System.Security.Principal.SecurityIdentifier($user)
#     $userName = $userName.Translate([System.Security.Principal.NTAccount]).Value

#     $logsTable += [pscustomobject]@{
#         "Time"  = $Eventlogs[$i].TimeWritten;
#         "Id"    = $Eventlogs[$i].InstanceId;
#         "Event" = $eventT;
#         "User"  = $userName;
#     }

#     $logsTable
# }

function Get-Logs($date) {
    $logs = Get-EventLog -LogName System -source Microsoft-Windows-WinLogon -After (Get-Date).AddDays(-$date)

    $logsTable = @()

    for ($i = 0; $i -lt $logs.count; $i++) {
        $eventT = ''
        if ($logs[$i].EventID -eq 7001) { $eventT = 'Logon' }
        if ($logs[$i].EventID -eq 7002) { $eventT = 'Logoff' }

        $user = $logs[$i].ReplacementStrings[1]
        $userName = New-Object System.Security.Principal.SecurityIdentifier($user)
        $userName = $userName.Translate([System.Security.Principal.NTAccount]).Value

        $logsTable += [pscustomobject]@{
            "Time"  = $logs[$i].TimeWritten;
            "Id"    = $logs[$i].InstanceId;
            "Event" = $eventT;
            "User"  = $userName;
        }
    }
    return $logsTable
}

# Get-Logs(1)

function Get-StartupShutdownLogs($date) {
    $logs = Get-EventLog -LogName System -After (Get-Date).AddDays(-$date) | Where-Object { $_.EventID -eq 6005 -or $_.EventID -eq 6006 }

    $logsTable = @()

    foreach ($log in $logs) {
        $eventT = if ($log.EventID -eq 6005) { 'Startup' } else { 'Shutdown' }

        $logsTable += [pscustomobject]@{
            "Time"  = $log.TimeWritten;
            "Id"    = $log.InstanceId;
            "Event" = $eventT;
            "User"  = "System";
        }
    }
    return $logsTable
}

# Get-StartupShutdownLogs(30)
