FROM nvidia/cuda:9.2-cudnn7-devel-ubuntu18.04
WORKDIR /app
COPY . .
RUN apt update \
    && apt install software-properties-common -y \
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && apt update \
    && apt -y install python python3-pip \
        git \
        wget \
        unzip \
        libsm6 libxext6 libxrender-dev \
    && pip3 install virtualenv \
    && python3 -m virtualenv . \
    && . bin/activate \ 
    && pip3 install -r requirements.txt
