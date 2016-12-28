FROM        ubuntu:trusty
MAINTAINER  alexiynew

# Default command on startup.
CMD bash

# Setup packages.
RUN apt-get update && apt-get -y install cmake git
RUN clang++ --version
