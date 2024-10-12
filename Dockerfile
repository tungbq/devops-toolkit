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
    wget \
    unzip \
    openssh-client \
    locales \
    gss-ntlmssp \
    libicu70 \
    libssl3 \
    libc6 \
    libgcc1 \
    libgssapi-krb5-2 \
    liblttng-ust1 \
    libstdc++6 \
    zlib1g

# Install Python
ARG PYTHON_VERSION=3.11
RUN apt install -y python${PYTHON_VERSION} && \
    ln -sf /usr/bin/python${PYTHON_VERSION} /usr/bin/python3

# Install pip for Python 3.11
RUN curl -k https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3 get-pip.py && \
    rm get-pip.py

# Install Ansible
ARG ANSIBLE_VERSION=2.17.5
RUN python3 -m pip install ansible-core==${ANSIBLE_VERSION}

# Install Terraform
ARG TERRAFORM_VERSION=1.9.7
RUN mkdir /tmp/terraform_env/ && \
    cd /tmp/terraform_env/ && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    cp terraform /usr/local/bin/ && \
    rm -rf /tmp/terraform_env/

# Install Kubectl
ARG KUBECTL_VERSION=1.31.1
RUN mkdir /tmp/kubectl_env/ && \
    cd /tmp/kubectl_env/ && \
    curl -LO "https://dl.k8s.io/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    rm -rf /tmp/kubectl_env/

# Install Helm
ARG HELM_VERSION=3.16.2
RUN mkdir /tmp/helm_env/ && \
    cd /tmp/helm_env/ && \
    wget https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
    tar -xvzf helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    rm -rf /tmp/helm_env/

# Install AwsCLI
ARG AWSCLI_VERSION=2.18.5
RUN mkdir /tmp/awscli_env/ && \
    cd /tmp/awscli_env/ && \
    wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip" && \
    unzip awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip && \
    ./aws/install && \
    rm -rf /tmp/awscli_env/

# Install AzureCLI
ARG AZURECLI_VERSION=2.65.0
RUN mkdir -p /etc/apt/keyrings && \
    curl -sLS https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor | \
    tee /etc/apt/keyrings/microsoft.gpg > /dev/null && \
    chmod go+r /etc/apt/keyrings/microsoft.gpg && \
    AZ_DIST=$(lsb_release -cs) && \
    echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_DIST main" | \
    tee /etc/apt/sources.list.d/azure-cli.list && \
    apt-get update && \
    apt-get install --no-install-recommends -y azure-cli=$AZURECLI_VERSION-1~$AZ_DIST

# PowerShell Installation
ARG PS_VERSION=7.4.5
ARG PS_PACKAGE=powershell_${PS_VERSION}-1.deb_amd64.deb
ARG PS_PACKAGE_URL=https://github.com/PowerShell/PowerShell/releases/download/v${PS_VERSION}/${PS_PACKAGE}
ARG PS_INSTALL_VERSION=7

RUN curl -sSL ${PS_PACKAGE_URL} -o /tmp/powershell.deb && \
    apt-get install --no-install-recommends -y /tmp/powershell.deb && \
    rm /tmp/powershell.deb

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=false \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    PS_INSTALL_FOLDER=/opt/microsoft/powershell/$PS_INSTALL_VERSION \
    PSModuleAnalysisCachePath=/var/cache/microsoft/powershell/PSModuleAnalysisCache/ModuleAnalysisCache \
    POWERSHELL_DISTRIBUTION_CHANNEL=PSDocker-Ubuntu-22.04

RUN locale-gen $LANG && update-locale && \
    export POWERSHELL_TELEMETRY_OPTOUT=1 && \
    chmod a+x,o-w ${PS_INSTALL_FOLDER}/pwsh && \
    ln -sf ${PS_INSTALL_FOLDER}/pwsh /usr/bin/pwsh && \
    pwsh -NoLogo -NoProfile -Command " \
        \$ErrorActionPreference = 'Stop' ; \
        \$ProgressPreference = 'SilentlyContinue' ; \
        \$maxTries = 0 ; \
        while(!(Test-Path -Path \$env:PSModuleAnalysisCachePath)) {  \
            Write-Host 'Waiting for $env:PSModuleAnalysisCachePath' ; \
            Start-Sleep -Seconds 6 ; \
            \$maxTries++ ; \
            if(\$maxTries -gt 20) {  \
                Write-Error 'Failed to create $env:PSModuleAnalysisCachePath' ; \
                exit 1 ; \
            } ; \
        }"

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

# Copy the entrypoint script into the container
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint to the entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Define the default command to run when the container starts
CMD ["/bin/bash"]
