$wallpaper_dir = Get-Location
$change_seconds = 300

$images = Get-ChildItem -Path $wallpaper_dir -Recurse -Include "*.jpg", "*.jpeg", "*.png" -File | Select-Object -ExpandProperty FullName

if($images.Count == 0) {
    exit 1
}

while($true) {
    $image_index = Get-Random -Minimum 0 -Maximum $images.Count
    $image_selec = $images[$image_index]

    if(Test-Path $image_selec -PathType Leaf) {
        Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name Wallpaper -Value $image_selec
        RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
    }
    Start-Sleep -Seconds $change_seconds
}