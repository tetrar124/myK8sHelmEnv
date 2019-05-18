@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
choco install -y anaconda3
choco install -y docker-for-windows
choco install -y vivaldi
choco install -y git.install
choco install -y mendeley
choco install -y pycharm-community
choco install -y github-desktop
choco install -y googledrive
choco install -y google-drive-file-stream
choco install -y -google-chrome-x64
choco install -y notepadplusplus
choco install -y slack
choco install -y mousewithoutborders
