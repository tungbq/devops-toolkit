<h1 align="center">DevOps Toolkit</h1>

<p align="center">Container image for an all-in-one DevOps environment with popular tools like Ansible, Terraform, kubectl, AWS CLI, Azure CLI, Git, and more...</p>

<p align="center">
  <a href="https://img.shields.io/github/last-commit/tungbq/devops-toolkit/main"><img alt="last commit" src="https://img.shields.io/github/last-commit/tungbq/devops-toolkit/main" /></a>
  <a href="[https://github.com/tungbq/devops-toolkit/stargazers](https://github.com/tungbq/devops-toolkit/actions/workflows/docker-image-main.yml/badge.svg)">
     <img alt="Docker main" src="https://github.com/tungbq/devops-toolkit/actions/workflows/docker-image-main.yml/badge.svg"/></a>
  <a href="https://github.com/tungbq/devops-toolkit/stargazers"><img alt="GitHub Repo stars" src="https://img.shields.io/github/stars/tungbq/devops-toolkit"/></a>
</p>

## Key features

- **Pre-installed Tools**: Includes a variety of essential tools such as git, python, ansible, terraform, kubectl, helm, awscli, azurecli, etc.
- **Continuous Integration**: Utilizes full CI/CD for deployment to Docker Hub using GitHub Actions.
- **Documentation**: Provides detailed documentation for each tool included.
- **Regular Updates**: Weekly checks and updates for core tools ensure the toolkit's reliability and security.
- **Sample code**: Included sample code of various tool in the toolkit

## Prerequisites

Before you begin, make sure you have [Docker](https://docs.docker.com/engine/install/) installed. It's also beneficial to have a basic understanding of Docker concepts.

## Quick start

```bash
docker run --network host -it --rm tungbq/devops-toolkit:latest
```

## Demo

Check out the full sample and instruction at [samples](./samples/)

```bash
docker run --network host --rm tungbq/devops-toolkit:latest samples/run_sample.sh
```

## Getting started

### Pull the official image from Docker Hub

DockerHub image [tungbq/devops-toolkit](https://hub.docker.com/r/tungbq/devops-toolkit)

```bash
docker pull tungbq/devops-toolkit:latest
```

### Build your own image

If you prefer to build your own image from the source code, refer to the [**build_toolkit_image**](./docs/build/build_toolkit_image.md) instructions.

### Start and explore the toolkit container

Once you have the image ready, you can start using the toolkit with the following commands

- Start devops-toolkit container

```bash
docker run --network host -it --rm tungbq/devops-toolkit:latest
```

- Now we are in the docker container terminal, let's explore it

```bash
root@docker-desktop:~# python3 --version
Python 3.12.2

root@docker-desktop:~# terraform --version
Terraform v1.7.5
on linux_amd64

root@docker-desktop:~# kubectl version
Client Version: v1.29.3
Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3

# ... more command as your needed
```

## User guide 📖

Check the below document for the detailed usage of each tool in the tool kit

- [**DevOps toolkit user guide**](./docs/usage/README.md)

## The DevOps Toolkit Core

Built on `ubuntu:22.04` base image

| Name      | Version                 | Release                                                                                            |
| :-------- | :---------------------- | :------------------------------------------------------------------------------------------------- |
| Python    | PYTHON_VERSION=3.12.2   | [Check](https://www.python.org/downloads/source/)                                                  |
| Ansible   | ANSIBLE_VERSION=2.16.4  | [Check](https://docs.ansible.com/ansible/latest/reference_appendices/release_and_maintenance.html) |
| Terraform | TERRAFORM_VERSION=1.7.5 | [Check](https://releases.hashicorp.com/terraform/)                                                 |
| Kubectl   | KUBECTL_VERSION=1.29.3  | [Check](https://dl.k8s.io/release/stable.txt)                                                      |
| Helm      | HELM_VERSION=3.14.3     | [Check](https://github.com/helm/helm/releases)                                                     |
| AwsCLI    | AWSCLI_VERSION=2.15.30  | [Check](https://raw.githubusercontent.com/aws/aws-cli/v2/CHANGELOG.rst)                            |
| AzureCLI  | AZURECLI_VERSION=2.58.0 | [Check](https://learn.microsoft.com/en-us/cli/azure/release-notes-azure-cli)                       |

And more tools to be implemented...

## Contributing

- See: [CONTRIBUTING.md](./CONTRIBUTING.md)
- Looking for the issue to work on? Check the list of our open issues [**good first issue**](https://github.com/tungbq/devops-toolkit/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22)
- Feel free to open a new issue if you want to request more content about DevOps Dockerfile

## Hit the Star! ⭐

- If you find this repository helpful, kindly consider showing your appreciation by giving it a star ⭐ Thanks! 💖
