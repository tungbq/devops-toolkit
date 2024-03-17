## Background
In the world of DevOps, managing multiple tools on your computer can be quite a challenge. I know this struggle firsthand. Setting up each tool, ensuring they work together, and keeping them updated is a time-consuming and often frustrating process.

That's why I created the [DevOps Toolkit](https://github.com/tungbq/devops-toolkit) to solve these problems.
It's built on top of the [docker](https://www.docker.com/) platform. I wanted to make it easier for developers and operations teams to get started with DevOps without the headaches of tool compatibility, setup, maintenance, and keeping everything up to date.

## The DevOps Toolkit
- **GitHub repository:** [tungbq/devops-toolkit](https://github.com/tungbq/devops-toolkit)
- **Description:** DevOps toolkit is a container image for an all-in-one DevOps environment with popular tools like Ansible, Terraform, kubectl, helm, AWS CLI, Azure CLI, Git, Python and more...

## Key features

- **Pre-installed Tools**: Includes a variety of essential tools such as git, python, ansible, terraform, kubectl, helm, awscli, azurecli, etc.
- **Continuous Integration**: Utilizes full CI/CD for deployment to Docker Hub using GitHub Actions.
- **Documentation**: Provides detailed documentation for each tool included.
- **Regular Updates**: Weekly checks and updates for core tools ensure the toolkit's reliability and security.
- **Sample code**: Includes sample code demonstrating the usage of various tools available in the toolkit.
- **Support for Build Variants**: Enables users to customize the toolkit by building it with their preferred versions of each tool.

## Prerequisites 🔓

Before you begin, ensure that you have [Docker](https://docs.docker.com/engine/install/) installed. It's also helpful to have a basic understanding of Docker concepts.
If you are new to docker, don't worry, you can refer to this [document](https://github.com/tungbq/devops-basic/tree/main/topics/docker) to get started.

## Quick start 🔥

```bash
docker run --network host -it --rm tungbq/devops-toolkit:latest
```

## Demo 📺

Check out the full sample and instruction at [samples](https://github.com/tungbq/devops-toolkit/tree/main/samples/)

```bash
docker run --network host --rm tungbq/devops-toolkit:latest samples/run_sample.sh
```

## Getting started 📖

### 1-Pull the official image from Docker Hub

DockerHub image: [tungbq/devops-toolkit](https://hub.docker.com/r/tungbq/devops-toolkit)

```bash
docker pull tungbq/devops-toolkit:latest
```

### 2-Build your own image (Optional)
Skip this step if you use the image from Dockerhub
- If you prefer to build your own image from the source code, refer to the [**build_toolkit_image**](https://github.com/tungbq/devops-toolkit/tree/main/docs/build/build_toolkit_image.md) instructions.
- We can customize the toolkit by building it with our preferred versions of each tool.

### 3-Start and explore the toolkit container

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

# ... more commands as your needed
```

## User guide 📖

Explore the comprehensive guide below to gain insight into the detailed utilization of every tool within the toolkit

- [**DevOps toolkit user guide**](https://github.com/tungbq/devops-toolkit/tree/main/docs/usage/README.md)

## The DevOps Toolkit Core 🧰

Built on `ubuntu:22.04` base image

| Name      | Version                 | Release                                                                      | Usage                                              |
| :-------- | :---------------------- | :--------------------------------------------------------------------------- | :------------------------------------------------- |
| Python    | PYTHON_VERSION=3.12.2   | [Check](https://www.python.org/downloads/source/)                            | [python_usage](https://github.com/tungbq/devops-toolkit/tree/main/docs/usage/python_usage.md)       |
| Ansible   | ANSIBLE_VERSION=2.16.4  | [Check](https://api.github.com/repos/ansible/ansible/releases/latest)        | [ansible_usage](https://github.com/tungbq/devops-toolkit/tree/main/docs/usage/ansible_usage.md)     |
| Terraform | TERRAFORM_VERSION=1.7.5 | [Check](https://releases.hashicorp.com/terraform/)                           | [terraform_usage](https://github.com/tungbq/devops-toolkit/tree/main/docs/usage/terraform_usage.md) |
| Kubectl   | KUBECTL_VERSION=1.29.3  | [Check](https://dl.k8s.io/release/stable.txt)                                | [kubectl_usage](https://github.com/tungbq/devops-toolkit/tree/main/docs/usage/kubectl_usage.md)     |
| Helm      | HELM_VERSION=3.14.3     | [Check](https://github.com/helm/helm/releases)                               | [helm_usage](https://github.com/tungbq/devops-toolkit/tree/main/docs/usage/helm_usage.md)           |
| AwsCLI    | AWSCLI_VERSION=2.15.30  | [Check](https://raw.githubusercontent.com/aws/aws-cli/v2/CHANGELOG.rst)      | [awscli_usage](https://github.com/tungbq/devops-toolkit/tree/main/docs/usage/awscli_usage.md)       |
| AzureCLI  | AZURECLI_VERSION=2.58.0 | [Check](https://learn.microsoft.com/en-us/cli/azure/release-notes-azure-cli) | [azurecli_usage](https://github.com/tungbq/devops-toolkit/tree/main/docs/usage/azurecli_usage.md)   |

_**NOTE:** This is the latest version as of the time I write this blog post. The DevOps Toolkit repository has an automated CI pipeline that checks and updates these tools weekly to the latest versions._

And more upcoming content...⏩ you can follow this repository to get more up-to-dated features

## Conclusion
In summary, the DevOps Toolkit simplifies the complexities of managing multiple DevOps tools and keeping them updated. If you're interested, give it a try, share your feedback, and let's continue improving together. Happy coding! 💖

[**Star devops-toolkit ⭐️ on GitHub**](https://github.com/tungbq/devops-toolkit)