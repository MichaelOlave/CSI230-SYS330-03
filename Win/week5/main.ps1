."Win\week5\Apache-Logs.ps1"
."Win\week5\webScrapping.ps1"

Write-Output "IP Addresses:"
Get-Ips -page "page5" -code "404" -browser "Edg"

Write-Output "Formated Logs:"
ApacheLogs1

Write-Output "Web Scraping Assignment:"
ScrapePage

$FullTable = daysTranslator(gatherClasses)

Write-Output "Filter by Instructor:"
$FullTable | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | Where-Object { $_."Instructor" -ilike "Furkan Paligu" }

Write-Output "Filter by Location:"
$FullTable | Where-Object { ($_.Location -ilike "JOYC 310") -and ($_.Days -contains "Monday") } |
Sort-Object "Time Start" |
Select-Object "Time Start", "Time End", "Class Code"

Write-Output "Instructors:"
$ITSInstructors = $FullTable | Where-Object {
    ($_."Class Code" -like "SYS*") -or
    ($_."Class Code" -like "NET*") -or
    ($_."Class Code" -like "SEC*") -or
    ($_."Class Code" -like "FOR*") -or
    ($_."Class Code" -like "CSI*") -or
    ($_."Class Code" -like "DAT*")
} | Select-Object Instructor -Unique | Sort-Object Instructor

$FullTable | Where-Object { $_.Instructor -in $ITSInstructors.Instructor } |
Group-Object "Instructor" |
Select-Object Count, Name |
Sort-Object Count -Descending