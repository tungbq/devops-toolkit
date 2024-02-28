# Use the official Ubuntu 22.04 base image
ARG UBUNTU_VERSION=22.04
FROM ubuntu:${UBUNTU_VERSION}

# Set environment variables to avoid interactive installation prompts
ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=UTC

# Update
RUN apt-get update

# Install required packages
RUN apt-get install -y \
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
    unzip \
    libbz2-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set Python version as an argument
ARG PYTHON_VERSION=3.11.3
# Install Python with specified version
RUN mkdir /tmp/python_env/ && \
    cd /tmp/python_env/ && \
    wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz && \
    tar -xf Python-${PYTHON_VERSION}.tgz && \
    cd Python-${PYTHON_VERSION} && \
    ./configure --enable-optimizations && \
    make -j$(nproc) && \
    make install && \
    cd / && \
    rm -rf /tmp/python_env/

# Install pip for Python 3.11
RUN curl -k https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.11 get-pip.py && \
    rm get-pip.py

# Install Ansible
# Docs: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible-with-pip
ARG ANSIBLE_VERSION=2.16.4
RUN python3 -m pip install ansible-core==${ANSIBLE_VERSION}

# Determine the latest Terraform version
ARG TERRAFORM_VERSION=1.7.4
RUN mkdir /tmp/terraform_env/ && \
    cd /tmp/terraform_env/ && \
    curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip "terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
    cp terraform_${TERRAFORM_VERSION}_linux_amd64/terraform /usr/local/bin/ && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Display Terraform version to verify installation
RUN terraform --version

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
