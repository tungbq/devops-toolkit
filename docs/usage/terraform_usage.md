# Use terraform in the devops-toolkit

## Terraform document

Some document to help you start with terraform

- <https://developer.hashicorp.com/terraform>
- <https://github.com/tungbq/devops-basic/tree/main/topics/terraform>

## Note

To use the existing container instead of creating one, use `docker exec` command instead of `docker run`

```bash
docker exec -it my_devops_toolkit /bin/bash
```

## Common Run Modes

For instructions on common run modes, visit [**DevOps Toolkit Common Run Mode**](../usage/run_mode.md).

## Use case 1: Run terraform sample code provided in the container

```bash
docker run --rm --network host -it -v ~/.devops-toolkit-config:/config tungbq/devops-toolkit:latest
# You now in the container terminal
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

## Use case 2: Clone external code inside container

```bash
docker run --rm --network host -it -v ~/.devops-toolkit-config:/config tungbq/devops-toolkit:latest
# You now in the container terminal

# Now run your cloned script
# Clone code
mkdir terraform_workspace; cd terraform_workspace
git clone <YOUR-REPO> terraform-examples

cd terraform-examples
# Run terraform here: init-plan-apply,...
```

## Use case 3: Mount external code to container

Clone the code to the host then mount to container

```bash
# Given that we have code somewhere in you machine
docker run --rm -v "$(pwd)":/root/terraform_workspace -v ~/.devops-toolkit-config:/config --network host -it tungbq/devops-toolkit:latest
# Run the terraform code as usual
```

## Troubleshooting

- For any issues, check [this reference](../troubleshooting/TROUBLESHOOTING.md)
