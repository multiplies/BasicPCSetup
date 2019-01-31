if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

function installProcess(){
    if($(Get-Process -Name Ninite -ErrorAction SilentlyContinue -ErrorVariable errorNinite) -and $(Get-Process -Name readerdc_nl_xa_crd_install -ErrorAction SilentlyContinue -ErrorVariable errorReaderDC)){
        return $true
    }else{
        $events = (Get-EventLog -LogName Application -EntryType Information -InstanceId 11707 -Source MsiInstaller -After $time -ErrorAction SilentlyContinue| where {$_.Message -like "*Adobe Acrobat Reader DC*"} -ErrorAction SilentlyContinue)
        if($events){
            installAdobeReaderDC
            return $true
        }else{
            return $false
        }
    }
}
function installAdobeReaderDC(){
    Start-Process -FilePath "$dir\readerdc_nl_xa_crd_install.exe" -Verb runAs
}

$dir = [Environment]::GetFolderPath("MyDocuments")
if(!$(Test-Path -Path $dir/temp)){
    mkdir "$dir\temp"
}
$dir = "$dir\temp"

$time = get-date

$date = (Get-Date -Format o).split(".")[0].Replace(":",".")
wget "https://ninite.com/.net4.7.2-7zip-air-chrome-java8-shockwave-silverlight-teamviewer/ninite.exe" -OutFile "$dir\ninite_$date.exe"

Start-Process -FilePath "$dir\ninite_$date.exe" -Verb runAs

Set-ItemProperty -Path 'Registry::HKU\.DEFAULT\Control Panel\Keyboard' -Name "InitialKeyboardIndicators" -Value "2147483650"

wget "https://raw.githubusercontent.com/multiplies/uwp_remove_list/master/uwp.txt" -OutFile "$dir\uwp.txt"

$uwp = Get-Content "$dir\uwp.txt"
$i = 1 
$uwp | foreach {
    $lines = $uwp.Length
    Write-Progress -Activity "Removing UWP Apps" -status "Removing app $_" -percentComplete ($i / $lines*100)
    get-appxpackage $_ | remove-appxpackage
    $i++
}

$url = 'https://admdownload.adobe.com/bin/live/readerdc_nl_xa_crd_install.exe'
wget $url -OutFile "$dir\readerdc_nl_xa_crd_install.exe"
installAdobeReaderDC

Start-Sleep -Seconds 60
Write-host "Waiting"
do{
    Write-Host '.' -NoNewline -ForegroundColor Magenta
    Start-Sleep -Seconds 10
}while(installProcess)

wget "https://raw.githubusercontent.com/multiplies/DefaultAppAssociations/master/DefaultAppAssociations.xml" -OutFile "$dir\DefaultAppAssociations.xml"
$DefaultAppAssociations = "$dir\DefaultAppAssociations.xml"
dism /online /Import-DefaultAppAssociations:"$DefaultAppAssociations"

remove-item -Path $dir -Force -Recurse