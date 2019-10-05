# Matterport3DSimulator
# Requires nvidia gpu with driver 384.xx or higher
# Add tuna source for faster deployment in the Chinese mainland

FROM nvidia/cudagl:9.0-devel-ubuntu16.04

# Replace the default sources.list with tuna sources.
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
COPY sources.list.tuna.16.04.txt /etc/apt/sources.list

# Install a few libraries to support both EGL and OSMESA options
RUN apt-get update && apt-get install -y wget doxygen curl libjsoncpp-dev libepoxy-dev libglm-dev libosmesa6 libosmesa6-dev libglew-dev libopencv-dev python-opencv python-setuptools python-dev
RUN easy_install pip
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -I numpy
RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple torch torchvision pandas networkx

#install latest cmake
ADD https://cmake.org/files/v3.12/cmake-3.12.2-Linux-x86_64.sh /cmake-3.12.2-Linux-x86_64.sh
RUN mkdir /opt/cmake
RUN sh /cmake-3.12.2-Linux-x86_64.sh --prefix=/opt/cmake --skip-license
RUN ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake
RUN cmake --version

