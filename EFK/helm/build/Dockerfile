FROM archlinux/base

## add user & SSH
RUN pacman -Syy
RUN	pacman -S --noconfirm curl zip unzip vim sudo base-devel go git 
RUN mkdir /var/run/sshd
# ARG user=makepkg
# RUN useradd -m $user
# RUN echo "$user ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/$user
# USER $user
# WORKDIR /home/$user
# RUN git clone https://aur.archlinux.org/yay.git \
#   && cd yay \
#   && makepkg -sri --needed --noconfirm \
#   && cd \
#   && rm -rf .cache yay
# USER root
#RUN archlinux-java set java-8-openjdk/jre
RUN pacman -S jre8-openjdk --noconfirm
RUN curl --create-dirs -o /.embulk/bin/embulk -L "http://dl.embulk.org/embulk-latest.jar"
RUN chmod +x /.embulk/bin/embulk
RUN /.embulk/bin/embulk --version