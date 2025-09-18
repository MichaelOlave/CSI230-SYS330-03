$PSPath = "./week2"
$files = Get-ChildItem -Path $PSPath -File

for ($i = 0; $i -lt $files.Length; $i++) {
    if ($files[$i].Name -ilike "*.ps1") {
        Write-Host $files[$i].Name
    }
}