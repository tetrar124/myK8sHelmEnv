FROM continuumio/anaconda3

RUN pip install tensorflow-gpu==2.0.0-alpha0 && \
conda install -y cudnn cudatoolkit numba && \
pip install -U pip && \
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