# Sample code for tools inside toolkit

## First step

Start and dive into the container

```bash
docker run -it --rm devops-toolkit:latest
```

Congrats! You now in the container and able to run the tooling sample inside toolkit, the console will look like:

```bash
root@05cf97a07b19:~#
```

## Python

```bash
python3 samples/python/rectangle_area_calculator.py
````

## Ansible

```bash
ansible-playbook samples/ansible/check_os.yml
```

## Terraform

```bash
#  Navigate to Terraform sample
pushd samples/terraform/basic
# Init the terraform
terraform init
# Apply change, select 'yes' to confirm
terraform apply
# Once done, destroy the infra, select 'yes' to confirm
terraform destroy
popd
```

## Kubectl
```bash
console_log "Running Kubectl sample: check version"
kubectl version
```bash

## Helm
```bash
console_log "Running Helm sample: add and search"
helm repo add bitnami https://charts.bitnami.com/bitnami
helm search repo bitnami | grep jenkins
```
## AwsCLI

- TODO

## AzureCLI

- TODO
