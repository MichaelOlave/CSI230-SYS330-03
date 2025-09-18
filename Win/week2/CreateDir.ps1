$folderPath = "week2\outfolder"

if (Test-Path -Path $folderPath) {
    Write-Host "Folder Already Exists!!"
}
else {
    New-Item -ItemType Directory -Path $folderPath
}