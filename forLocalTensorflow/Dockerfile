FROM continuumio/anaconda3

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd

ENV USER tatabox
ENV SHELL /bin/bash
RUN apt install -y sudo
RUN useradd -m ${USER}
RUN gpasswd -a ${USER} sudo
RUN echo "${USER}:kiyohara" | chpasswd && \
echo "/bin/bash" >> /home/${USER}/.bash_profile && \
echo "alias python="/opt/conda/bin/python"" >> /home/${USER}/.bash_profile
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
RUN conda install -c rdkit rdkit && \
pip install tensorflow-gpu==2.0.0-alpha0 && \
pip install python-louvain && \
conda install -y cudnn cudatoolkit numba && \
pip install -U pip && \
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