systemctl --user enable onedrive
systemctl --user start onedrive

sudo apt install  dphys-swapfile 
sudo dphys-swapfile swapoff && \
sudo dphys-swapfile uninstall && \
sudo systemctl disable dphys-swapfile