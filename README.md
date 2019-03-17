# WSL provision

WSL is the Windows Subsystem for Linux and can be installed on Windows 10.
A few tools are required to provision WSL instances and since it does not have a dedicated SSH server,
Ansbile playbooks have to be run locally.
This repository is aiming for a smooth WSL installation of Ubuntu or Debian to have independant environments
set up quickly. In order to run tests, builds or simply split environments (project1, project2, devzone,...)
this repository has been created and a supporting quick start guide https://screenzone.eu/provision-wsl-environment-using-ansible/.

# Requirements
* [Scoop](https://scoop.sh) - Helper application to install applications
* [LxRunOffline](https://github.com/DDoSolitary/LxRunOffline) - Manage WSL installations

## Install scoop
[Install scoop](https://github.com/lukesampson/scoop/wiki/Quick-Start) using Powershell as described.
```
$ set-executionpolicy remotesigned -scope currentuser
$ iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
$ scoop install git
```

## Install LxRunOffline
Install LxRunOffline using scoop. [Chocolatey](https://chocolatey.org/install) can be used too.
```
$ scoop bucket add extras
$ scoop install lxrunoffline
```
Check if installation is done successfully by executing
```
$ LxRunOffline l
```
This should list installed WSL environments if they are any.

## Install WSL environment using LxRunOffline
Run following commands with Powershell. Ensure to change into a temporary directory before to download the image file to a proper location.
```
# Download WSL ubuntu image
$ (New-Object System.Net.WebClient).DownloadFile('https://lxrunoffline.apphb.com/download/UbuntuFromMS/16', 'wsl-image.tar.gz')

# Install WSL in C:\WSL\wsl-1 using the previously downloaded image file
$ LxRunOffline i -n wsl-1 -d C:\WSL\wsl-1 -f .\wsl-image.tar.gz -s

# Create initial user
$ LxRunOffline su -n wsl-1 -v 1000
```

## Run ansible with sudo
In case a password for sudo is required, launch ansible-playbook with parameter --ask-become
