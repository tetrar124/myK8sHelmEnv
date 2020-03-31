FROM alpine:latest

RUN apk --update --no-cache
RUN apk add make gcc g++ --no-cache
#softether
RUN wget https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases/download/v4.30-9696-beta/softether-vpnserver-v4.30-9696-beta-2019.07.08-linux-x64-64bit.tar.gz
RUN tar -zxvf soft*
RUN cd vpnserver
RUN yes 1 | make
RUN find . -type f | chmod 600
RUN find . -type d | chmod 700
RUN chmod u+x .install.sh vpncmd vpnserver && cd
RUN sudo cp -rp vpnserver /usr/local/
RUN sudo chown -R root:root /usr/local/vpnserver/
RUN rm softether*
RUN /usr/local/vpnserver/vpnserver