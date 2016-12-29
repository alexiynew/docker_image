FROM        ubuntu:trusty
MAINTAINER  alexiynew

# Default command on startup.
CMD bash

# Prepare
RUN apt-get update
RUN apt-get -y install wget

# Update repositories
RUN wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key | apt-key add -
RUN apt-get update

# Setup packages.
RUN apt-get install -y --no-install-recommends cmake make
RUN apt-get install -y --no-install-recommends clang-3.8

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.8 100
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.8 100

# Cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Check version
RUN clang++ --version
