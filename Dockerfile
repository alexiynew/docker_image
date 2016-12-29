FROM        ubuntu:trusty
MAINTAINER  alexiynew

# Default command on startup.
CMD bash

# Prepare
RUN apt-get update
RUN apt-get -y install curl

# Update repositories
RUN curl -sSL "http://llvm.org/apt/llvm-snapshot.gpg.key" | sudo apt-key add - 
RUN echo 'deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.8 main' >> /etc/apt/sources.list
RUN apt-get update

# Setup packages.
RUN apt-get -y install cmake clang-3.8 lldb-3.8

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.8 100
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.8 100

# Cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Check version
RUN clang++ --version
