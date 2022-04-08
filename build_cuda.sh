source bin/activate
cd nms/src/cuda/
nvcc -c -o nms_kernel.cu.o nms_kernel.cu -x cu -Xcompiler -fPIC -arch=sm_61
cd ../../
python build.py
cd ../roialign/roi_align/src/cuda/
nvcc -c -o crop_and_resize_kernel.cu.o crop_and_resize_kernel.cu -x cu -Xcompiler -fPIC -arch=sm_61
cd ../../
python build.py
pip install torch==0.4.1 -f https://download.pytorch.org/whl/torch_stable.html
