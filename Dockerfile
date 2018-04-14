FROM        ubuntu:xenial
MAINTAINER  alexiynew

# Default command on startup
CMD bash

# Prepare
RUN apt-get update

# Setup packages
RUN apt-get install -y --no-install-recommends cmake make
RUN apt-get install -y --no-install-recommends clang-6.0 g++-7
RUN apt-get install -y --no-install-recommends python
RUN apt-get install -y --no-install-recommends git
RUN apt-get install -y --no-install-recommends xvfb
RUN apt-get install -y --no-install-recommends lcov
RUN apt-get install -y --no-install-recommends curl

# Install libraries
RUN apt-get install -y --no-install-recommends libx11-dev

# Setup compillers
RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-6.0 100
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-6.0 100
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 100
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 100

# Cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Check version
RUN clang++ --version
RUN g++ --version
RUN python --version
