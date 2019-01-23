if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

$dir = [Environment]::GetFolderPath("MyDocuments")

$date = (Get-Date -Format o).split(".")[0].Replace(":",".")
wget "https://ninite.com/.net4.7.2-7zip-air-chrome-java8-shockwave-silverlight-teamviewer/ninite.exe" -OutFile "$dir\ninite_$date.exe"

Start-Process -FilePath "$dir\ninite_$date.exe" -Verb runAs

Set-ItemProperty -Path 'Registry::HKU\.DEFAULT\Control Panel\Keyboard' -Name "InitialKeyboardIndicators" -Value "2147483650"

get-appxpackage *candy* | remove-appxpackage
get-appxpackage *fitbit* | remove-appxpackage
get-appxpackage *Microsoft.Office.Desktop* | remove-appxpackage
Get-AppxPackage *news* | remove-appxpackage
Get-AppxPAckage *C27EB4BA.DropboxOEM* | remove-appxpackage
Get-AppxPackage *Amazon.com.Amazon* | remove-appxpackage
Get-AppxPackage *5A894077.McAfeeSecurity* | remove-appxpackage
Get-AppxPackage *MicrosoftSolitaireCollection* | Remove-AppxPackage
Get-AppxPackage *ThumbmunkeysLtd.PhototasticCollage* | Remove-AppxPackage

Start-Sleep -Seconds 25

$url = 'https://get.adobe.com/nl/reader'

(New-Object -Com Shell.Application).Open($url)

Wait-Process -Name Ninite
rm "$dir\ninite_$date.exe" -force