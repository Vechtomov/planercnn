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
    # TODO: fix source not found
    && source bin/activate \ 
    && pip3 install -r requirements.txt \
    && nvcc -c -o nms_kernel.cu.o nms_kernel.cu -x cu -Xcompiler -fPIC -arch=sm_61 \
    && cd ../../ \
    && python build.py \
    && cd ../roialign/roi_align/src/cuda/ \
    && nvcc -c -o crop_and_resize_kernel.cu.o crop_and_resize_kernel.cu -x cu -Xcompiler -fPIC -arch=sm_61 \
    && cd ../../ \
    && python build.py \
    && cd ../../ \
    && pip install torch==0.4.1 -f https://download.pytorch.org/whl/torch_stable.html
