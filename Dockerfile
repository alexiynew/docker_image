FROM        ubuntu:xenial
MAINTAINER  alexiynew

# Default command on startup.
CMD bash

# Prepare
RUN apt-get update

# Setup packages.
RUN apt-get install -y --no-install-recommends cmake make
RUN apt-get install -y --no-install-recommends clang-3.8 g++-5
RUN apt-get install -y --no-install-recommends python

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.8 100
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.8 100
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 100
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-5 100

# Cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Check version
RUN clang++ --version
RUN g++ --version
RUN python --version
