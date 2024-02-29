<h1 align="center">DevOps Toolkit</h1>

<p align="center">Container image for an all-in-one DevOps environment with popular tools like Ansible, Terraform, kubectl, AWS CLI, Azure CLI, Git, and more...</p>

<p align="center">
  <a href="https://img.shields.io/github/last-commit/tungbq/devops-toolkit/main"><img alt="last commit" src="https://img.shields.io/github/last-commit/tungbq/devops-toolkit/main" /></a>
  <a href="https://github.com/tungbq/devops-toolkit/stargazers"><img alt="GitHub Repo stars" src="https://img.shields.io/github/stars/tungbq/devops-toolkit"/></a>
</p>

## Prerequisites

Before you begin, make sure you have [Docker](https://docs.docker.com/engine/install/) installed. It's also beneficial to have a basic understanding of Docker concepts.

## How to Build

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/tungbq/devops-toolkit.git
   ```

2. **Navigate to the Repository:**

   ```bash
   cd devops-toolkit
   ```

3. **Navigate to the Repository:**

   ```bash
   docker build -t devops-toolkit:latest .
   ```

4. **Run the Docker Image (Optional):**

- Start container

  ```bash
  docker run -it --rm devops-toolkit:latest
  ```

- Check python version

  ```bash
  docker run --rm devops-toolkit:latest python3 --version
  ```

<!-- . **Customize the Build (Optional):** -->

## Use the image from Docker Hub
- To be implemented

## Test the image
```bash
cd scripts
chmod +x check_version_in_toolkit.sh
.check_version_in_toolkit.sh devops-toolkit:latest
```

## Contributing

- See: [CONTRIBUTING.md](./CONTRIBUTING.md)
- Looking for the issue to work on? Check the list of our open issues [**good first issue**](https://github.com/tungbq/devops-toolkit/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22)
- Feel free to open a new issue if you want to request more content about DevOps Dockerfile

## Hit the Star! ⭐

- If you find this repository helpful, kindly consider showing your appreciation by giving it a star ⭐ Thanks! 💖
