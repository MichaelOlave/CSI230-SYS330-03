$directory = "C:\Users\WindowsXI\Desktop\CSI230\week2"

$outputFolder = "C:\Users\WindowsXI\Desktop\CSI230\week2\outfolder"
$outputFile = "out.csv"

$ps1Files = Get-ChildItem -Path $directory

$ps1Files | Where-Object { $_.Extension -eq ".ps1" } | Export-Csv -Path (Join-Path $outputFolder $outputFile) -NoTypeInformation