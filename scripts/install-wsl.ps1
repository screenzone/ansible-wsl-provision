#
# Create WSL environment and provision it using Ansible
#

# Parameters to run this script
param (
  [ValidatePattern('https?://(-\.)?([^\s/?\.#-]+\.?)+(/[^\s]*)')][string]$imageUrl = "http://lxrunoffline.apphb.com/download/UbuntuFromMS/16",
  [string]$imageDownloadFile = "$PSScriptRoot\wsl-image.tar.gz",
  [Parameter(Mandatory=$true)][string]$wslName = "wsl-1"
)

# Check if LxRunOffline is working
"List of existing WSL environments"
LxRunOffline l

if ($?) {
  # Download image file
  "Download $imageUrl .."
  (New-Object System.Net.WebClient).DownloadFile($imageUrl, $imageDownloadFile)

  if ($?) {
    "Create WSL $wslName .."
    LxRunOffline i -n $wslName -d C:\WSL\$wslName -f $imageDownloadFile -s 

    if ($?) {
      "Run ansible in WSL .."
      LxRunOffline r -n $wslName -c "apt update && apt install -y git && git clone https://github.com/screenzone/ansible-wsl-provision.git /root/provision && cd /root/provision && ansible-playbook -i inventory init-wsl.yml"
      LxRunOffline su -n $wslName -v 1000
    } else {
      "WSL install failed."
    }
  } else {
    "Image download failed!"
  # Cleanup
  rm $imageDownloadFile
  }
} else {
  "LxRunOffline not working properly"
}
