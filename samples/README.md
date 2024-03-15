# Sample code for tools inside toolkit

## Start and dive into the container
```bash
docker run -it --rm devops-toolkit:latest
```

## Python
```bash
python3 samples/python/rectangle_area_calculator.py
````

## Ansible
```bash
ansible-playbook samples/ansible/check_os_version.yaml
```

## Terraform
```bash
#  Navigate to Terraform sample
cd samples/terraform/basic
# Init the terraform
terraform init

# Apply change, select 'yes' to confirm
terraform apply

# Once done, destroy the infra, select 'yes' to confirm
terraform destroy
```


