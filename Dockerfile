# Use the official Ubuntu 22.04 base image
ARG UBUNTU_VERSION=22.04
FROM ubuntu:${UBUNTU_VERSION}

# Set environment variables to avoid interactive installation prompts
ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=UTC

# Update and install required packages
RUN apt-get update && \
    apt-get install -y \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    tzdata \
    git \
    jq \
    curl \
    docker.io \
    postgresql-client \
    mysql-client \ 
    # Dev tools
    build-essential \
    zlib1g-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libreadline-dev \
    libffi-dev \
    libsqlite3-dev \
    wget \
    libbz2-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

## Set Python 3.11 as the default python version
RUN mkdir /tmp/python_env/ && \
    cd /tmp/python_env/ && \
    wget https://www.python.org/ftp/python/3.11.3/Python-3.11.3.tgz && \
    tar -xf Python-3.11.3.tgz && \
    cd Python-3.11.3 && \
    ./configure --enable-optimizations && \
    make -j$(nproc) && \
    make install && \
    cd / && \
    rm -rf /tmp/python_env/

# Install pip for Python 3.11
RUN curl -k https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.11 get-pip.py && \
    rm get-pip.py

# Cleanup
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Reset environment variables
ENV DEBIAN_FRONTEND teletype
ENV TZ=""

# Set the working directory
WORKDIR /root

# Define the default command to run when the container starts
CMD ["/bin/bash"]
