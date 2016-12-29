FROM        ubuntu:trusty
MAINTAINER  alexiynew

# Default command on startup.
CMD bash

# Update repositories
RUN wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key | apt-key add -
# RUN curl -sSL "http://llvm.org/apt/llvm-snapshot.gpg.key" | sudo apt-key add
RUN echo 'deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.8 main' >> /etc/apt/sources.list
RUN apt-get update

# Setup packages.
RUN apt-get -y install cmake clang-3.8 lldb-3.8
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.8 100
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.8 100

# Check version
RUN clang++ --version
