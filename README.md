# BasicPCSetup

This is a powershell script that installs basic software and removes bloatware (UWP APPS) of a computer.
It also sets some settings correct.

## Usage
Download the the powershell script and run it with powershell.

[**download here**]('https://github.com/multiplies/BasicPCSetup/releases/download/v1.0/BasicInstallion.ps1')

After downloading unzip the file and run BasicPCSetup.ps1.

![alt text](https://github.com/multiplies/BasicPCSetup/raw/master/images/RunScript.gif )

## Installed software
This script installs programs from different sources.

### Ninite
From ninite the following programs are installed:
1. Google Chrome
1. .NET 4.7.2
1. 7zip
1. Adobe Air
1. Jave 8
1. Teamviewer
1. Adobe Shockwave
1. Microsoft Silverlicht

### Adobe Reader DC
Adobe reader Dc gets downloaded from Adobe and then installed.

## Removing Default UWP Apps
The scipt downloads a file with different UWP Apps to delete.
The list can be found [here]('https://github.com/multiplies/uwp_remove_list/blob/master/uwp.txt').

## Renaming PC Name
When the script runs it'll ask to enter a new PC name, when the script ran it will reboot the PC.

## Setting default settings
The script will also set some default settings. At the moment it settings the numlock on at start up.