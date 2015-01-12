FROM ubuntu
MAINTAINER Ryan Baumann <ryan.baumann@gmail.com>

# Update/install Ubuntu packages.
RUN apt-get update
RUN apt-get install -y git wget vim

# Set the locale.
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# More environment variables.
ENV LD_LIBRARY_PATH /usr/local/lib
WORKDIR /home

# Download and install ocropus
RUN git clone https://github.com/tmbdev/ocropy.git
RUN cd ocropy; sudo apt-get install -y $(cat PACKAGES)
RUN cd ocropy; wget -nd http://www.tmbdev.net/en-default.pyrnn.gz
RUN cd ocropy; mv en-default.pyrnn.gz models/
RUN cd ocropy; python setup.py install
RUN cd ocropy; ./run-test
