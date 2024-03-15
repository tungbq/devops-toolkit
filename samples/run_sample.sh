#!/bin/bash

# Function to log messages with INFO prefix
console_log() {
  echo "[INFO] $1"
}

###########
# Python
###########
console_log "Running Python sample: rectangle_area_calculator.py"
python3 samples/python/rectangle_area_calculator.py

###########
# Ansible
###########
console_log "Running Ansible sample: check_os.yml"
ansible-playbook samples/ansible/check_os.yml

###########
# Terraform
###########
console_log "Running Terraform sample: basic"
pushd samples/terraform/basic || exit
terraform init
terraform apply -auto-approve
terraform destroy -auto-approve
popd || exit
