@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
choco install anaconda3
choco install docker-for-windows
choco install vivaldi
choco install git.install
choco install mendeley
choco install pycharm-community
choco install github-desktop
choco install googledrive
choco install google-drive-file-stream