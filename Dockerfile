FROM        ubuntu:xenial
MAINTAINER  alexiynew

# Default command on startup
CMD ./misc/docker_run.sh

# Environment variables
ENV DEBIAN_FRONTEND noninteractive

# Prepare
RUN apt-get update && apt-get install -y --no-install-recommends curl wget software-properties-common

# Add repositories
RUN wget --no-check-certificate -O - https://apt.llvm.org/llvm-snapshot.gpg.key|apt-key add - && \
    add-apt-repository "deb http://apt.llvm.org/xenial/ llvm-toolchain-xenial-6.0 main" &&       \
    add-apt-repository ppa:jonathonf/gcc-7.1

# Install packages
RUN apt-get update && apt-get install -y --no-install-recommends pkg-config clang-6.0 g++-7 ninja-build\
 python3 python3-pip python3-setuptools\
 xserver-xorg-video-dummy x11-apps openbox tint2 menu libx11-dev libgl1-mesa-dev

RUN python3 -m pip install --upgrade pip && pip3 install meson

# Setup Xdummy
RUN wget https://xpra.org/xorg.conf -O xorg.conf

# Setup compillers
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-6.0 100 &&       \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-6.0 100 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 100 &&               \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 100

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
