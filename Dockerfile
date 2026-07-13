# Use the official Ubuntu 24.04 base image
ARG UBUNTU_VERSION=24.04
FROM ubuntu:${UBUNTU_VERSION}

# Set environment variables to avoid interactive installation prompts
ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=UTC

# Install required packages + Python in a single layer so the apt cache
# never lingers in the image (deleting it in a later layer does not shrink
# the layer that downloaded it).
# Package names below are Ubuntu 24.04 (noble)'s post 64-bit-time_t-transition
# names: libicu74 (was libicu70), libssl3t64 (was libssl3), libgcc-s1 (was
# libgcc1), liblttng-ust1t64 (was liblttng-ust1).
ARG PYTHON_VERSION=3.12
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
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
    libicu74 \
    libssl3t64 \
    libc6 \
    libgcc-s1 \
    libgssapi-krb5-2 \
    liblttng-ust1t64 \
    libstdc++6 \
    zlib1g \
    python${PYTHON_VERSION} && \
    ln -sf /usr/bin/python${PYTHON_VERSION} /usr/bin/python3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install pip for Python 3.12
# --break-system-packages: Ubuntu 24.04 marks the system Python as
# "externally managed" (PEP 668) and refuses plain pip installs. That
# protection exists to stop pip from fighting apt on a general-purpose
# system - it doesn't apply here, since this container's system Python
# is entirely dedicated to running this toolkit.
RUN curl -k https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3 get-pip.py --break-system-packages && \
    rm get-pip.py

# Install Ansible
# cryptography is pinned explicitly (rather than left to ansible-core's
# transitive resolution) because older wheels bundle a vulnerable OpenSSL
ARG ANSIBLE_VERSION=2.21.1
ARG CRYPTOGRAPHY_VERSION=49.0.0
RUN python3 -m pip install --break-system-packages ansible-core==${ANSIBLE_VERSION} cryptography==${CRYPTOGRAPHY_VERSION}

# Install Terraform
ARG TERRAFORM_VERSION=1.15.8
RUN mkdir /tmp/terraform_env/ && \
    cd /tmp/terraform_env/ && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    cp terraform /usr/local/bin/ && \
    rm -rf /tmp/terraform_env/

# Install Kubectl
ARG KUBECTL_VERSION=1.36.2
RUN mkdir /tmp/kubectl_env/ && \
    cd /tmp/kubectl_env/ && \
    curl -LO "https://dl.k8s.io/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv ./kubectl /usr/local/bin/kubectl && \
    rm -rf /tmp/kubectl_env/

# Install Helm
ARG HELM_VERSION=3.21.3
RUN mkdir /tmp/helm_env/ && \
    cd /tmp/helm_env/ && \
    wget https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
    tar -xvzf helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    rm -rf /tmp/helm_env/

# Install GitHub CLI
ARG GH_VERSION=2.96.0
RUN mkdir /tmp/gh_env/ && \
    cd /tmp/gh_env/ && \
    wget https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_amd64.tar.gz && \
    tar -xvzf gh_${GH_VERSION}_linux_amd64.tar.gz && \
    cp gh_${GH_VERSION}_linux_amd64/bin/gh /usr/local/bin/gh && \
    rm -rf /tmp/gh_env/

# Install AwsCLI
ARG AWSCLI_VERSION=2.35.21
RUN mkdir /tmp/awscli_env/ && \
    cd /tmp/awscli_env/ && \
    wget "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip" && \
    unzip awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip && \
    ./aws/install && \
    rm -rf /tmp/awscli_env/

# Install AzureCLI
ARG AZURECLI_VERSION=2.88.0
RUN mkdir -p /etc/apt/keyrings && \
    curl -sLS https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor | \
    tee /etc/apt/keyrings/microsoft.gpg > /dev/null && \
    chmod go+r /etc/apt/keyrings/microsoft.gpg && \
    AZ_DIST=$(lsb_release -cs) && \
    echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_DIST main" | \
    tee /etc/apt/sources.list.d/azure-cli.list && \
    apt-get update && \
    apt-get install --no-install-recommends -y azure-cli=$AZURECLI_VERSION-1~$AZ_DIST && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    # azure-cli vendors its own venv under /opt/az with its own pinned deps,
    # separate from the system pip environment - patch its cryptography too.
    # Use "python3 -m pip", not the "pip" console script: azure-cli's deb
    # ships that script with a shebang baked in from Microsoft's own build
    # environment (/mnt/repo/python_env/bin/python3), which doesn't exist here.
    /opt/az/bin/python3 -m pip install --no-cache-dir --break-system-packages --upgrade "cryptography==${CRYPTOGRAPHY_VERSION}"

# Install Google Cloud CLI
ARG GCLOUD_VERSION=575.0.1
RUN mkdir -p /tmp/gcloud_env/ && \
    cd /tmp/gcloud_env/ && \
    wget "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${GCLOUD_VERSION}-linux-x86_64.tar.gz" && \
    tar -xzf google-cloud-cli-${GCLOUD_VERSION}-linux-x86_64.tar.gz -C /opt && \
    /opt/google-cloud-sdk/install.sh --quiet --usage-reporting=false --path-update=false --command-completion=false --rc-path=/dev/null && \
    ln -sf /opt/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud && \
    ln -sf /opt/google-cloud-sdk/bin/gsutil /usr/local/bin/gsutil && \
    ln -sf /opt/google-cloud-sdk/bin/bq /usr/local/bin/bq && \
    rm -rf /tmp/gcloud_env/

# PowerShell Installation
ARG PS_VERSION=7.6.3
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
    POWERSHELL_DISTRIBUTION_CHANNEL=PSDocker-Ubuntu-24.04

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
