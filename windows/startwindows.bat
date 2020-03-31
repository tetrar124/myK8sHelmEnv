@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
choco install -y vivaldi
choco install -y anaconda3
#add PAtH
setx PATH "%PATH%;C:\tools\Anaconda3\Scripts"

choco install -y ChocolateyGUI 
choco install -y vcxsrv
choco install -y thunderbird
choco install -y kubernetes-helm
choco install -y libreoffice-fresh
choco install -y docker-for-windows
choco install -y git.install --params "/GitAndUnixToolsOnPath"
choco install -y mendeley
choco install -y pycharm-community
choco install -y github-desktop
choco install -y googledrive
#choco install -y google-drive-file-stream
choco install -y -google-chrome-x64
choco install -y notepadplusplus
choco install -y slack
choco install -y vscode
#choco install -y mousewithoutborders
choco install -y gimp
choco install -y wsl-ubuntu-1804
#choco install -y steam
choco install -y jre8
choco install -y -y mozbackup & echo Yes
pip install lightgbm
pip install -U rgf_python
pip install -U xgboost
pip install -U bayesian-optimization
pip install -U mlxtend
pip install tensorflow-gpu==2.0.0-alpha0
pip install python-louvain
conda install -y cudnn cudatoolkit numba
conda install -c rdkit rdkit
"C:\Program Files\Mozilla Thunderbird\thunderbird.exe" -p
#C:\OneDrive\Programfiles\mailprifile