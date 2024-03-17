# Build your own devops-toolkit image

**NOTE:** If you'd refer using the official prebuilt docker image from DockerHub, you can skip this section!
Jump to [Use Docker Hub image](https://github.com/tungbq/devops-toolkit?tab=readme-ov-file#use-the-official-image-from-docker-hub) for instead.

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
./check_version_in_toolkit.sh devops-toolkit:latest ./toolkit_info.json
```
