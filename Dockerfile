# Use the official Ubuntu 22.04 base image
ARG UBUNTU_VERSION=22.04
FROM ubuntu:${UBUNTU_VERSION}

# Set environment variables to avoid interactive installation prompts
ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=UTC

# Update
RUN apt-get update

# Install required packages
RUN apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    git \
    jq \
    curl \
    wget \
    unzip

# Set Python version as an argument
ARG PYTHON_VERSION=3.11
# Install Python with specified version
RUN apt install -y python${PYTHON_VERSION} && \
    ln -sf /usr/bin/python3.11 /usr/bin/python3

# Install pip for Python 3.12
RUN curl -k https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3 get-pip.py && \
    rm get-pip.py

# Install Ansible
# Docs: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-and-upgrading-ansible-with-pip
ARG ANSIBLE_VERSION=2.17.0
RUN python3 -m pip install ansible-core==${ANSIBLE_VERSION}

# Install Terraform
ARG TERRAFORM_VERSION=1.8.5
RUN mkdir /tmp/terraform_env/ && \
    cd /tmp/terraform_env/ && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    cp  terraform /usr/local/bin/ && \
    rm -rf /tmp/terraform_env/

# Install Kubectl
ARG KUBECTL_VERSION=1.30.1
RUN mkdir /tmp/kubectl_env/ && \
    cd /tmp/kubectl_env/ && \
    curl -LO "https://dl.k8s.io/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    rm -rf /tmp/kubectl_env/

# Install Helm
ARG HELM_VERSION=3.15.1
RUN mkdir /tmp/helm_env/ && \
    cd /tmp/helm_env/ && \
    wget https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
    tar -xvzf helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    rm -rf /tmp/helm_env/

# Install AwsCLI
ARG AWSCLI_VERSION=2.16.4
RUN mkdir /tmp/awscli_env/ && \
    cd /tmp/awscli_env/ && \
    wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip" && \
    unzip awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip && \
    ./aws/install && \
    rm -rf /tmp/awscli_env/

# Install AzureCLI
ARG AZURECLI_VERSION=2.61.0
RUN mkdir -p /etc/apt/keyrings && \
    curl -sLS https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor | \
    tee /etc/apt/keyrings/microsoft.gpg > /dev/null && \
    chmod go+r /etc/apt/keyrings/microsoft.gpg && \
    AZ_DIST=$(lsb_release -cs) && \
    echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_DIST main" | \
    tee /etc/apt/sources.list.d/azure-cli.list && \
    apt-get update && \
    # Install a specific version
    apt-get install --no-install-recommends -y azure-cli=$AZURECLI_VERSION-1~$AZ_DIST

# Cleanup
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /root

# Adding tooling samples
COPY samples/ /root/samples/
RUN chmod +x /root/samples/run_sample.sh

# Reset environment variables
ENV DEBIAN_FRONTEND teletype
ENV TZ=""

# Define the default command to run when the container starts
CMD ["/bin/bash"]
