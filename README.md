<p align="center">
  <a href="https://github.com/tungbq/devops-toolkit"><img src="./assets/images/devops-toolkit.jpg" alt="devops-toolkit" height="300"></a>
</p>

<h1 align="center">DevOps Toolkit</h1>

<p align="center">🐳 Container image for an all-in-one DevOps environment with popular tools like Ansible, Terraform, kubectl, AWS CLI, Azure CLI, Git, Python and more...</p>

<p align="center">
  <a href="https://img.shields.io/github/last-commit/tungbq/devops-toolkit/main"><img alt="last commit" src="https://img.shields.io/github/last-commit/tungbq/devops-toolkit/main" /></a>
  <a href="https://github.com/tungbq/devops-toolkit/releases"><img alt="devops-toolkit release" src="https://img.shields.io/github/release/tungbq/devops-toolkit.svg" /></a>
  <a href="[https://hub.docker.com/r/tungbq/devops-toolkit/tags](https://github.com/tungbq/devops-toolkit/actions/workflows/deploy-docker-image-release.yml/badge.svg)">
     <img alt="Docker main" src="https://github.com/tungbq/devops-toolkit/actions/workflows/deploy-docker-image-release.yml/badge.svg"/></a>
  <a href="https://img.shields.io/docker/pulls/tungbq/devops-toolkit"><img alt="tungbq/devops-toolkit" src="https://img.shields.io/docker/pulls/tungbq/devops-toolkit"/></a>
  <a href="https://github.com/tungbq/devops-toolkit/stargazers"><img alt="GitHub Repo stars" src="https://img.shields.io/github/stars/tungbq/devops-toolkit"/></a>
</p>

## Key Features

- **Comprehensive Toolset**: Pre-installed with tools like Git, Python, Ansible, Terraform, kubectl, Helm, AWS CLI, Azure CLI, and more.
- **Easy Integration**: Use it directly or customize it with your preferred versions.
- **Efficient Updates**: Weekly updates ensure the latest versions and security patches.
- **Configuration Reusability**: Mounts host config folders for seamless reuse across sessions.

## Getting Started

### 1. Quick Start

```bash
mkdir -p $HOME/.dtc # Skip this step if you already created the configuration folder before
docker pull tungbq/devops-toolkit:latest
docker run -it --rm --name devops-toolkit-demo1 \
    -v $HOME/.dtc:/dtc \
    --network host  \
    tungbq/devops-toolkit:latest
```

### 2. Run with custom tool config from host (.dtc)
Mount current directory and start the toolkit
```bash
docker run -it --name devops-toolkit-demo2 \
    --volume "$PWD:$PWD" \
    --volume "$HOME/.dtc:/dtc" \
    --volume "$HOME/.ssh:/root/.ssh" \
    --workdir "$PWD" \
    --network host \
    tungbq/devops-toolkit:latest

# Adjust the docker run command base on your use cases
```

### 3. Run with tool config from host

```bash
docker run -it --name devops-toolkit-demo3 \
    --volume "$HOME/.aws:/root/.aws" \
    --volume "$HOME/.azure:/root/.azure" \
    --volume "$HOME/.kube:/root/.kube" \
    --volume "$HOME/.terraform.d:/root/.terraform.d" \
    --volume "$HOME/.config/helm:/root/.config/helm" \
    --volume "$HOME/.ansible:/root/.ansible" \
    --volume "$HOME/.gitconfig:/root/.gitconfig" \
    --volume "$HOME/.ssh:/root/.ssh" \
    --volume "$PWD:$PWD" \
    --workdir "$PWD" \
    --network host \
    tungbq/devops-toolkit:latest

# Adjust the docker run command base on your use cases
```

### 4. Note

- `.dtc` stands for **D**evOps **T**oolkit **C**onfiguration
- You can replace `$HOME/.dtc` with any desired folder path on your VM.
- Remove the `-v $HOME/.dtc:/dtc` option if you do not wish to store configurations on the host (not recommended for configuration reuse).

## Versioning

We use the following versioning scheme:

- **Repository Tags**: `vX.Y.Z` (e.g., `v1.2.3`)
- **Docker Tags**: `X.Y.Z` or `latest` for the most recent version.

You can pull specific versions from Docker Hub using:

```bash
docker pull tungbq/devops-toolkit:1.2.3
docker pull tungbq/devops-toolkit:latest
```

For more details on versioning, check the [**release notes**](https://github.com/tungbq/devops-toolkit/releases).

## User Guide 📖

Explore the comprehensive guide below to gain insight into the detailed utilization of every tool within the toolkit.

- For detailed instructions on using specific tools, refer to: [**DevOps toolkit specific tool user guide**](./docs/usage/README.md)
- For instructions on common run modes, visit [**DevOps toolkit common run mode**](./docs/usage/run_mode.md)

## Demo 📺

- Checkout the Demo code and instruction [here](./demo/).

## The DevOps Toolkit Core 🧰

Built on `ubuntu:22.04` base image

| Name       | Version                 | Release                                                                      | Usage                                              |
| :--------- | :---------------------- | :--------------------------------------------------------------------------- | :------------------------------------------------- |
| Python     | PYTHON_VERSION=3.11     | [Check](https://www.python.org/downloads/source/)                            | [python_usage](./docs/usage/python_usage.md)       |
| Ansible    | ANSIBLE_VERSION=2.18.3  | [Check](https://api.github.com/repos/ansible/ansible/releases/latest)        | [ansible_usage](./docs/usage/ansible_usage.md)     |
| Terraform  | TERRAFORM_VERSION=1.11.2 | [Check](https://releases.hashicorp.com/terraform/)                           | [terraform_usage](./docs/usage/terraform_usage.md) |
| Kubectl    | KUBECTL_VERSION=1.32.3  | [Check](https://dl.k8s.io/release/stable.txt)                                | [kubectl_usage](./docs/usage/kubectl_usage.md)     |
| Helm       | HELM_VERSION=3.17.2     | [Check](https://github.com/helm/helm/releases)                               | [helm_usage](./docs/usage/helm_usage.md)           |
| AwsCLI     | AWSCLI_VERSION=2.24.24  | [Check](https://raw.githubusercontent.com/aws/aws-cli/v2/CHANGELOG.rst)      | [awscli_usage](./docs/usage/awscli_usage.md)       |
| AzureCLI   | AZURECLI_VERSION=2.70.0 | [Check](https://learn.microsoft.com/en-us/cli/azure/release-notes-azure-cli) | [azurecli_usage](./docs/usage/azurecli_usage.md)   |
| PowerShell | PS_VERSION=7.5.0        | [Check](https://github.com/PowerShell/PowerShell/releases)                   | TODO                                               |

And more tools to be implemented...

## Contributing

- See: [CONTRIBUTING.md](./CONTRIBUTING.md)
- Looking for the issue to work on? Check the list of our open issues [**good first issue**](https://github.com/tungbq/devops-toolkit/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22)
- Feel free to open a new issue if you encounter the toolkit bug or want to request more content about DevOps toolkit
- Submit a [new issue](https://github.com/tungbq/devops-toolkit/issues/new) (🐛) if you encounter the bug/error when using this toolkit

## Hit the Star! ⭐

- If you find this repository helpful, kindly consider showing your appreciation by giving it a star ⭐ Thanks! 💖
