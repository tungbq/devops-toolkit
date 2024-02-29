<h1 align="center">DevOps Toolkit</h1>

<p align="center">Container image for an all-in-one DevOps environment with popular tools like Ansible, Terraform, kubectl, AWS CLI, Azure CLI, Git, and more...</p>

<p align="center">
  <a href="https://img.shields.io/github/last-commit/tungbq/devops-toolkit/main"><img alt="last commit" src="https://img.shields.io/github/last-commit/tungbq/devops-toolkit/main" /></a>
  <a href="https://github.com/tungbq/devops-toolkit/stargazers"><img alt="GitHub Repo stars" src="https://img.shields.io/github/stars/tungbq/devops-toolkit"/></a>
</p>

## Prerequisites

Before you begin, make sure you have [Docker](https://docs.docker.com/engine/install/) installed. It's also beneficial to have a basic understanding of Docker concepts.

## Build your own image

_NOTE:_ If you'd refer using the official prebuilt docker image from DockerHub, you can skip this section!

**1. Clone the Repository:**

```bash
git clone https://github.com/tungbq/devops-toolkit.git
```

**2. Navigate to the Repository:**

```bash
cd devops-toolkit
```

**3. Build the DevOps toolkit image:**

- Build with the default versions

```bash
docker build -t devops-toolkit:latest .
```

- Build with single custom version

```bash
docker build \
  --build-arg TERRAFORM_VERSION=1.7.0 \
  -t devops-toolkit:custom .
```

- Build with multiple custom versions

```bash
docker build \
  --build-arg UBUNTU_VERSION=22.04 \
  --build-arg PYTHON_VERSION=3.11.3 \
  --build-arg ANSIBLE_VERSION=2.16.3 \
  --build-arg TERRAFORM_VERSION=1.7.0 \
  --build-arg KUBECTL_VERSION=1.29.2 \
  --build-arg HELM_VERSION=3.14.2 \
  --build-arg AWSCLI_VERSION=2.15.24 \
  -t devops-toolkit:custom .
```

**4. Test the toolkit image:**

- Run below command to verify newly created image

```bash
cd scripts
chmod +x check_version_in_toolkit.sh
.check_version_in_toolkit.sh devops-toolkit:latest
```

## Use the official image from Docker Hub
```bash
docker pull tungbq/devops-toolkit:latest
```

## Use the toolkit image

One we have the image ready, let's play with it!

- Start toolkit container

```bash
docker run -it --rm devops-toolkit:latest
```

- Run python command to check version

```bash
docker run --rm devops-toolkit:latest python3 --version
```

- Run ansible command to check version

```bash
docker run --rm devops-toolkit:latest python3 --version
```

## The DevOps Toolkit Core

Built on `ubuntu:22.04` base image

| Name      | Version                 | Release                                                                                            |
| :-------- | :---------------------- | :------------------------------------------------------------------------------------------------- |
| Python    | PYTHON_VERSION=3.11.3   | [Check](https://www.python.org/downloads/source/)                                                  |
| Ansible   | ANSIBLE_VERSION=2.16.4  | [Check](https://docs.ansible.com/ansible/latest/reference_appendices/release_and_maintenance.html) |
| Terraform | TERRAFORM_VERSION=1.7.4 | [Check](https://releases.hashicorp.com/terraform/)                                                 |
| Kubectl   | KUBECTL_VERSION=1.29.2  | [Check](https://dl.k8s.io/release/stable.txt)                                                      |
| Helm      | HELM_VERSION=3.14.2     | [Check](https://github.com/helm/helm/releases)                                                     |
| Awscli    | AWSCLI_VERSION=2.15.24  | [Check](https://raw.githubusercontent.com/aws/aws-cli/v2/CHANGELOG.rst)                            |

And more tools to be implemented...

## Contributing

- See: [CONTRIBUTING.md](./CONTRIBUTING.md)
- Looking for the issue to work on? Check the list of our open issues [**good first issue**](https://github.com/tungbq/devops-toolkit/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22)
- Feel free to open a new issue if you want to request more content about DevOps Dockerfile

## Hit the Star! ⭐

- If you find this repository helpful, kindly consider showing your appreciation by giving it a star ⭐ Thanks! 💖
