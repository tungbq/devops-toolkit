#!/bin/bash

# Define color variables
GREEN='\033[0;32m' # Green color
NC='\033[0m'       # No color (reset)

# Function to log messages with INFO prefix in green color
console_log() {
  message=$1
  echo -e "${GREEN}[INFO] $message ${NC}"
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
