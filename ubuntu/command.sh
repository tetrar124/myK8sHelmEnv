sudo apt update
sudo apt -y upgrade
gsettings set org.gnome.desktop.interface enable-animations false 

#net tools
sudo apt -y install net-tools
sudo apt -y install ssh
sudo apt -y install ethtool
sudo apt -y install git

#bashmarks https://github.com/huyng/bashmarks
git clone git://github.com/huyng/bashmarks.git
cd bashmarks
make install
echo -e '
source ~/.local/bin/bashmarks.sh'>> ~.bash_profile
# s <bookmark_name> - Saves the current directory as "bookmark_name"
# g <bookmark_name> - Goes (cd) to the directory associated with "bookmark_name"
# p <bookmark_name> - Prints the directory associated with "bookmark_name"
# d <bookmark_name> - Deletes the bookmark
# l                 - Lists all available bookmarks

#mellanox
wget http://www.mellanox.com/downloads/ofed/MLNX_EN-4.6-1.0.1.1/mlnx-en-4.6-1.0.1.1-ubuntu18.04-x86_64.tgz
tar xzvf mlnx*.tgz
cd mlnx-en-4.6-1.0.1.1-ubuntu18.04-x86_64/
sudo ./install
sudo ip link set enp1s0 mtu 9014

#IME
sudo apt install -y fcitx fcitx-mozc

#kubernetes
sudo apt install -y docker.io
sudo systemctl enable docker
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo apt install -y kubeadm kubelet kubectl
sudo apt-mark hold kubeadm kubelet kubectl
sudo swapoff –a 
#ホスト名の設定
sudo hostnamectl set-hostname master-node
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
##CoreDNS will not start up before a network is installed. kubeadm only supports Container Network Interface (CNI) based networks (and does not support kubenet)
sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
#マスターノードにもpod配置を許可（taintを削除）
kubectl taint nodes --all node-role.kubernetes.io/master-

kubectl get pods --all-namespaces


#after reboot(only add # to the line of /swap for always swap off )
sudo cp /etc/fstab /etc/fstab.bak
#永続的にスワップオフ
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

#power saving
sudo add-apt-repository ppa:linrunner/tlp
sudo apt -y install tlp tlp-rdw powertop
sudo tlp start
#電圧調整コマンド
sudo sed -i 's/"quiet splash"/"quiet splash amdgpu.ppfeaturemask=0xffff3fff"/g' /etc/default/grub
sudo echo -e 'u
GRUB_DISABLE_OS_PROBER=true' >> /etc/default/grub

#GRUBメニューの表示
sudo sed -i 's/GRUB_TIMEOUT_STYLE=hidden/GRUB_TIMEOUT_STYLE=menu/g'  /etc/default/grub
sudo sed -i 's/GRUB_TIMEOUT=0/GRUB_TIMEOUT=10/g'  /etc/default/grub
sudo update-grub

# #windows パーティッションの探索
# #*がついたNTFSのあるパーティッションを探す
# sudo fdisk -l
# #見つけたパーティッションにおけるUUIDの確認
# sudo blkid /dev/sdc1

# #下記を追加することでgrubのブートローダー一覧にWindows 10を追加
# sudo su -
# echo -e 'menuentry “Microsoft Windows 10” {
# search -–set=root –-no-floppy –-fs-uuid 8EF467F0F467D94B
# chainloader (${root})/EFI/BOOT/fbx64.efi
# }'>>/etc/grub.d/40_custom
# BOOTX64.efi

# grub >ls
# menuentry "Windows" {
#     set root='(hd2,msdos1)'
#     chainloader /EFI/BOOT/fbx64.efi
# }>>/etc/grub.d/40_custom

# exit
# sudo chomod 755 /etc/grubd./40_custom

# sudo update-grub
# sudo grub-mkconfig -o /boot/grub/grub.cfg


#sudo systemctl start tlp
#sudo systemctl enable tlp

#cronで2時にシャットダウン
sudo su -
sudo echo '00 2	* * *	root	shutdown -h now >> shutdown.log 2>&1 | logger -t shutdown -p local0.info' >> /etc/crontab
exit

#samba
sudo apt-get install -y samba
sudo sed -i 's/workgroup = WORKGROUP/workgroup = TNETWORK/g'  /etc/samba/smb.conf
sudo /etc/init.d/smbd start
#pdbedit -a username

#onedrive
sudo apt install libcurl4-openssl-dev
sudo apt install libsqlite3-dev
sudo snap install --classic dmd && sudo snap install --classic dub
git clone https://github.com/skilion/onedrive.git
cd onedrive
sudo apt install git curl gcc make
make
sudo make install
onedrive
####################################################################
#URLをブラウザに入れて、変化したURLを再度コピーしてCLIに貼り付けてEnter #
####################################################################
systemctl --user enable onedrive
systemctl --user start onedrive

#other softwares
sudo apt install -y hardinfo
sudo apt install -y software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo add-apt-repository universe
sudo apt -y install ansible
sudo apt -y install steam-devices
sudo apt -y install vlc
sudo apt-get install gdebi -y 
wget srware.net/downloads/iron64.deb 
sudo gdebi -y iron64.deb 
sudo apt install -y vim
sudo apt install curl
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add -
sudo add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main'
sudo apt update && sudo apt install vivaldi-stable

#remote.it
sudo curl -LkO https://raw.githubusercontent.com/remoteit/installer/master/scripts/auto-install.sh
sudo chmod +x ./auto-install.sh
sudo ./auto-install.sh
sudo connectd_installer

#softether
docker run -d --rm --name softether-vpn-server -v softetherdata:/mypool/config  -p 992:992/tcp -p 1194:1194/udp -p 5555:5555/tcp -p 500:500/udp -p 4500:4500/udp -p 1701:1701/udp --cap-add NET_ADMIN toprock/softether

wget https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases/download/v4.30-9696-beta/softether-vpnserver-v4.30-9696-beta-2019.07.08-linux-x64-64bit.tar.gz
tar -zxvf soft*
cd vpnserver
yes 1 | make
find . -type f | chmod 600
find . -type d | chmod 700
chmod u+x .install.sh vpncmd vpnserver
cd
sudo cp -rp vpnserver /usr/local/
sudo chown -R root:root /usr/local/vpnserver/
sudo su -
sudo echo -e '[Unit]
Description=SoftEther VPN Server
After=network.target auditd.service
ConditionPathExists=!/usr/local/vpnserver/do_not_run

[Service]
Type=forking
EnvironmentFile=-/usr/local/vpnserver
ExecStart=/usr/local/vpnserver/vpnserver start
ExecStop=/usr/local/vpnserver/vpnserver stop
KillMode=process
Restart=on-failure

# Hardening
PrivateTmp=yes
ProtectHome=yes
ProtectSystem=full
ReadOnlyDirectories=/
ReadWriteDirectories=-/usr/local/vpnserver
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_BROADCAST CAP_NET_RAW CAP_SYS_NICE CAP_SYS_ADMIN CAP_SETUID

[Install]
WantedBy=multi-user.target
'>>/etc/systemd/system/vpnserver.service
exit
sudo systemctl daemon-reload
sudo systemctl enable vpnserver
sudo systemctl start vpnserver

#vpnclient
wget https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases/download/v4.30-9696-beta/softet
her-vpnclient-v4.30-9696-beta-2019.07.08-linux-x64-64bit.tar.gz
tar xzvf softether*
yes 1 | make
sudo mv vpnclient /usr/local
sudo chown -R root:root /usr/local/vpnclient/
cd /usr/local/vpnclient/
sudo chmod 600 *
sudo chmod 700 vpncmd
sudo chmod 700 vpnclient
sudo echo '[Unit]
Description=SoftEther VPN Client
After=network.target network-online.target

[Service]
ExecStart=/usr/local/vpnclient/vpnclient start
ExecStop=/usr/local/vpnclient/vpnclient stop
Type=forking
RestartSec=3s

[Install]
WantedBy=multi-user.target
'>>/etc/systemd/system/vpnclient.service
sudo systemctl start vpnclient
sudo systemctl enable vpnclient



sudo /usr/local/vpnclient/vpnclient start
sudo su - 
echo "2" "localhost" "NicCreate VPN"  "AccountCreate VPN_Server /SERVER:192.168.0.200:443 /HUB:TVPN /USERNAME:tataxbox /NICNAME:VPN" | /usr/local/vpnclient/vpncmd
sudo dhclient vpn_vpn

#black
sudo apt install -y gnome-tweaks
gnome-tweaks

#ansible-nas
git clone https://github.com/davestephens/ansible-nas.git && cd ansible-nas
cp group_vars/all.yml.dist  group_vars/all.yml
cp inventory.dist inventory
ansible-galaxy install -r requirements.yml
sudo ansible-playbook -i inventory nas.yml -b -K

#set ip and wake on lan
WOL_DISABLE=N
sudo sed -i 's/WOL_DISABLE=Y/WOL_DISABLE=N/g'  /etc/default/tlp

sudo echo -e '[Unit]
Description=Configure Wake On LAN

[Service]
Type=oneshot
ExecStart=/sbin/ethtool -s enp5s0 wol g

[Install]
WantedBy=basic.target' >> /etc/systemd/system/wol.service
sudo systemctl daemon-reload
sudo systemctl enable wol.service
sudo systemctl start wol.service

sudo su -
sudo echo -e '  ethernets:
        enp4s0:
            addresses:
            - 192.168.0.200/24
            gateway4: 192.168.0.2
            dhcp4: false
            dhcp6: false
            wakeonlan: true
            match:
                macaddress: 70:85:c2:cf:87:8a
            accept-ra: false
            nameservers:
                addresses:
                - 192.168.0.2
                - 8.8.8.8
        enp4s0:
            addresses:
            - 172.17.1.2/24
            
            dhcp4: false
            dhcp6: false
            wakeonlan: true
            accept-ra: false
' >> /etc/netplan/01-network-manager-all.yaml
sudo chmod 755 /etc/netplan/01-network-manager-all.yaml
sudo netplan apply
sudo /sbin/ifconfig vpn_vpn 192.168.0.201 netmask 255.255.255.0 broadcast 192.168.0.255
sudo /sbin/ifconfig tap_tap_server 192.168.0.202 netmask 255.255.255.0 broadcast 192.168.0.255

#sudo sed -i 's/console/anybody/g'  /etc/X11/Xwrapper.config 
#ZFS
sudo apt install -y debootstrap gdisk zfs-initramfs
#新規作成時のみ
sudo zpool create mypool /dev/sda /dev/sdb
sudo zfs set compression=lz4 mypool
sudo zfs create mypool/movies
sudo zfs create mypool/photos
sudo zfs create mypool/music
sudo zfs create mypool/trade
#既存ZFSの読み込み
sudo zpool import

#XRDP
sudo add-apt-repository ppa:martinx/xrdp-next
sudo apt update
sudo apt upgrade -y
sudo apt install -y xrdp xorg
echo mate-session> ~/.xsession
sudo apt -y install mate-core 
sudo ufw allow 3389/tcp
sudo reboot

#makegroup
#sudo groupadd tatabox
sudo chown -R kanalyst /mypool/trade
sudo chgrp -R tatabox /mypool/trade
sudo chmod -R 700 /mypool/trade

sudo chown -R kanalyst /mypool/movies
sudo chgrp -R tatabox /mypool/movies
sudo chmod -R 755 /mypool/trade
sudo chown -R kanalyst /mypool/photos
sudo chgrp -R tatabox /mypool/photos
sudo chmod -R 755 /mypool/trade
sudo chown -R kanalyst /mypool/music
sudo chgrp -R tatabox /mypool/music
sudo chmod -R 755 /mypool/music
#sync

sudo sed -i 's/RSYNC_ENABLE=false/RSYNC_ENABLE=true/g' /etc/default/rsync
sudo service rsync start
sudo systemctl enable rsync.service
sudo apt  -y install nmap

su -
sudo echo -e '
[TRADE]
   comment=user data
   path=/mypool/trade
   read only=false
   uid=kanalyst
   gid=kanalyst
   hosts allow=192.168.0.100
   hosts deny=*
[MOVIE]
   comment=user data
   path=/mypool/movies
   read only=false
   uid=kanalyst
   gid=kanalyst
   hosts allow=192.168.0.100
   hosts deny=*
[PHOTO]
   comment=user data
   path=/mypool/photos
   read only=false
   uid=kanalyst
   gid=kanalyst
   hosts allow=192.168.0.100
   hosts deny=*
[MUSIC]
   comment=user data
   path=/mypool/music
   read only=false
   uid=kanalyst
   gid=kanalyst
   hosts allow=192.168.0.100
   hosts deny=*
' >> /etc/rsyncd.conf
exit

rsync -av kanalyst@192.168.0.200::TRADE /volume1/トレード/config/mv/
rsync -av kanalyst@192.168.0.200::MOVIE /volume1/video/temp
rsync -av kanalyst@192.168.0.200::PHOTO /volume1/photo/tata
rsync -av /volume1/music/Music/ kanalyst@192.168.0.200::MUSIC 


