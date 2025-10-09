. (Join-Path $PSScriptRoot ..\week5\Apache-Logs.ps1)
. (Join-Path $PSScriptRoot ..\week6\Event-Logs.ps1)
. (Join-Path $PSScriptRoot ..\week2\ProcessManagement1_1.ps1)

Clear-Host

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display last 10 Apache logs`n"
$Prompt += "2 - Display last 10 failed logins for all users`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Start Chrome web browser and navigate to champlain.edu`n"
$Prompt += "5 - Exit`n"

$operation = $true

while ($operation) {

    Write-Host $Prompt | Out-String
    $choice = Read-Host "Enter your choice (1-5)"

    if ($choice -notmatch '^[1-5]$') {
        Write-Host "`nInvalid input! Please enter a number between 1 and 5.`n" -ForegroundColor Red
        continue
    }

    if ($choice -eq 5) {
        Write-Host "`nExiting program. Goodbye!`n" -ForegroundColor Green
        $operation = $false
    }

    elseif ($choice -eq 1) {
        Write-Host "`nDisplaying last 10 Apache logs...`n" -ForegroundColor Cyan
        $apacheLogs = ApacheLogs1
        Write-Host ($apacheLogs | Select-Object -Last 10 | Format-Table -AutoSize | Out-String)
    }

    elseif ($choice -eq 2) {
        Write-Host "`nDisplaying last 10 failed logins for all users...`n" -ForegroundColor Cyan
        $days = Read-Host "Enter number of days to check for failed logins"

        if ($days -notmatch '^\d+$') {
            Write-Host "`nInvalid input! Please enter a valid number of days.`n" -ForegroundColor Red
            continue
        }

        $failedLogins = getFailedLogins $days

        if ($failedLogins.Count -eq 0) {
            Write-Host "`nNo failed logins found in the last $days days.`n" -ForegroundColor Yellow
        }
        else {
            Write-Host ($failedLogins | Select-Object -Last 10 | Format-Table -AutoSize | Out-String)
        }
    }

    elseif ($choice -eq 3) {
        Write-Host "`nDisplaying at risk users (more than 10 failed logins)...`n" -ForegroundColor Cyan
        $days = Read-Host "Enter number of days to check for failed logins"

        if ($days -notmatch '^\d+$') {
            Write-Host "`nInvalid input! Please enter a valid number of days.`n" -ForegroundColor Red
            continue
        }

        $failedLogins = getFailedLogins $days

        if ($failedLogins.Count -eq 0) {
            Write-Host "`nNo failed logins found in the last $days days.`n" -ForegroundColor Yellow
            continue
        }

        Write-Host "Checking for users with more than 10 failed logins...`n"

        $checkedUsers = @()
        $atRiskFound = $false

        foreach ($log in $failedLogins) {
            $user = $log.User

            if ($checkedUsers -contains $user) {
                continue
            }

            $count = 0
            foreach ($entry in $failedLogins) {
                if ($entry.User -eq $user) {
                    $count = $count + 1
                }
            }

            if ($count -gt 10) {
                Write-Host "$user has $count failed logins in the last $days days." -ForegroundColor Yellow
                $atRiskFound = $true
            }

            $checkedUsers += $user
        }

        if (-not $atRiskFound) {
            Write-Host "`nNo at-risk users found.`n" -ForegroundColor Green
        }
        else {
            Write-Host "`nDone checking failed logins.`n"
        }
    }

    elseif ($choice -eq 4) {
        Write-Host "`nChecking for Chrome instances...`n" -ForegroundColor Cyan

        $chromeProcess = Get-Process -Name chrome -ErrorAction SilentlyContinue

        if ($null -eq $chromeProcess) {
            try {
                Start-Process "chrome.exe" "https://www.champlain.edu"
                Write-Host "Started Chrome and navigated to champlain.edu.`n" -ForegroundColor Green
            }
            catch {
                Write-Host "Error: Could not start Chrome. Please ensure Chrome is installed.`n" -ForegroundColor Red
            }
        }
        else {
            Write-Host "Chrome is already running. Not starting a new instance.`n" -ForegroundColor Yellow
        }
    }
}
