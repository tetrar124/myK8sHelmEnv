FROM continuumio/anaconda3
RUN apt -y update;apt -y upgrade;apt install -y openssh-server
RUN mkdir /var/run/sshd
RUN sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config &&\
echo "root:kiyohara" | chpasswd && \
echo "alias python="/opt/conda/bin/python"" >> /etc/profile.d/default.sh
ENV NOTVISIBLE "in users profile"
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
#spark
RUN curl -O http://ftp.tsukuba.wide.ad.jp/software/apache/spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.7.tgz &&\
tar -zxvf spark-2.4.3-bin-hadoop2.7.tgz &&\
mv spark-2.4.3-bin-hadoop2.7 /usr/local/spark 
RUN echo "export SPARK_HOME=/usr/local/spark"  >> /etc/environment
RUN echo "export PATH=${PATH}:/usr/local/spark/bin" >> ~/.profile
RUN echo 'PermitUserEnvironment yes' >> /etc/ssh/sshd_config 
RUN echo ${PATH}