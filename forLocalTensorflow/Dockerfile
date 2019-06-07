FROM continuumio/anaconda3

RUN apt update && apt install -y openssh-server curl zip unzip vim
RUN mkdir /var/run/sshd
ENV USER tatabox
ENV SHELL /bin/bash
RUN apt install -y sudo
RUN useradd -m ${USER}
RUN gpasswd -a ${USER} sudo
RUN echo "${USER}:kiyohara" | chpasswd && \
echo "/bin/bash" >> /etc/profile.d/default.sh  && \
echo "alias python="/opt/conda/bin/python"" >> /etc/profile.d/default.sh
ENV NOTVISIBLE "in users profile"
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

#root user
RUN echo "root:kiyohara" | chpasswd && \
sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config

#java,spark,kotlin
ENV SDKMAN_DIR /usr/local/sdkman 
SHELL ["/bin/bash", "-c"]
RUN curl -s "https://get.sdkman.io" | bash &&\
source "/usr/local/sdkman/bin/sdkman-init.sh" \
;sdk install java;sdk install kotlin;sdk install gradle;sdk install scala;sdk flush archives;
#sdk install spark;sdk install sbt
RUN echo "export SDKMAN_DIR="/usr/local/sdkman""  >> /etc/environment  

# spark
RUN curl -O http://ftp.tsukuba.wide.ad.jp/software/apache/spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.7.tgz &&\
tar -zxvf spark-2.4.3-bin-hadoop2.7.tgz &&\
mv spark-2.4.3-bin-hadoop2.7 /usr/local &&\
ln -s spark-2.4.3-bin-hadoop2.7 /usr/local/spark 
RUN echo "export SPARK_HOME=/usr/local/spark"  >> /etc/environment
ENV PATH ${PATH}:/usr/local/spark/bin
RUN source /usr/local/sdkman/bin/sdkman-init.sh;echo "export PATH=${PATH}:/usr/local/spark/bin" >> ~/.profile
RUN source /usr/local/sdkman/bin/sdkman-init.sh;echo "export PATH=${PATH}:/usr/local/spark/bin" >> /home/${USER}/.profile
#RUN echo "source ~/.profile" >> /etc/profile.d/default.sh

RUN mkdir  ~/.ssh/ && mkdir /home/${USER}/.ssh/
RUN touch ~/.ssh/environment && touch /home/${USER}/.ssh/environment
RUN echo 'PermitUserEnvironment yes' >> /etc/ssh/sshd_config 
RUN source /usr/local/sdkman/bin/sdkman-init.sh;echo "export PATH=${PATH}:/usr/local/spark/bin" >> ~/.ssh/environment
RUN source /usr/local/sdkman/bin/sdkman-init.sh;echo "export PATH=${PATH}:/usr/local/spark/bin" >> /home/${USER}/.ssh/environment

#path and env of sdkman for all user 
#RUN echo "/bin/bash source "/usr/local/sdkman/bin/sdkman-init.sh"" >> /etc/profile.d/default.sh &&\
#echo "/bin/bash -c "/usr/local/sdkman/bin/sdkman-init.sh"" >> /etc/profile.d/default.sh &&\
#RUN echo "bash -c "source  ~/.profile"" >> /etc/profile.d/default.sh

#RDkit
RUN conda install -c rdkit rdkit

#Deep learning
RUN pip install -U pip
RUN conda install -c rdkit rdkit && \
pip install tensorflow-gpu==2.0.0-alpha0 && \
pip install python-louvain && \
conda install -y cudnn cudatoolkit numba && \

#others
pip install cairosvg && \
apt install -y --reinstall build-essential && \
apt-get install -y python-dev libopenblas-dev && \
git clone --recursive https://github.com/ibayer/fastFM.git && \
cd fastFM && \
pip install -r ./requirements.txt && \
PYTHON=python3 make && \  
pip install . && \
pip install fastprogress japanize-matplotlib && \
pip install xgboost &&\
pip install lightgbm &&\
pip install rgf-python &&\
pip install mlxtend &&\
pip install bayesian-optimization

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES utility,compute

# Reinforcement learning
RUN apt -y install git gcc make openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev  python3-tk tk-dev python-tk libfreetype6-dev python-dev cmake zlib1g-dev libjpeg-dev xvfb libav-tools xorg-dev python-opengl libboost-all-dev libsdl2-dev swig
RUN pip install gym && \
pip install gym[classic_control] &&\
pip install gym[box2d] && \
git clone https://github.com/openai/baselines.git &&\
cd baselines &&\
pip install -e . &&\
pip install pytest &&\
pip install gym-retro

# clean up 
RUN apt clean
# start up
RUN chmod 755 /etc/profile.d/default.sh