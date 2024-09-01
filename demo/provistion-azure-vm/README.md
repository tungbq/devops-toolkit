# DEMO: Provision Azure VM with DevOps toolkit

## Navigate to Terraform demo code

```bash
cd devops-toolkit/demo/provistion-azure-vm
```

## Init devops-toolkit container

```bash
devops-toolkit-cli init demo_azure_tf
```

## Run devops-toolkit container

```bash
devops-toolkit-cli run demo_azure_tf
```

At this point, your container already started with `demo/provistion-azure-vm` code available inside. Let's move to the next step

## Login to Azure

```bash
# In devops-toolkit contaienr env
az account show
az login --use-device-code
# Follow the cmd output to login
```

## Initialize Terraform

```bash
# In devops-toolkit contaienr env
terraform init
```

## Plan Terraform

```bash
# In devops-toolkit contaienr env
terraform plan
```

## Apply Terraform

```bash
# In devops-toolkit contaienr env
terraform apply
```

Enter 'yes' to confirm

## Verify

- Now you can go to Azure Portal to verify your VM: https://portal.azure.com/#home
- Or ping the Public IP shown in the console

## Cleanup
Destroy the resources with terraform if they are not used anymore:
```bash
# In devops-toolkit contaienr env
terraform destroy
```

And also remove the demo docker container with this command:
```bash
devops-toolkit-cli cleanup demo_azure_tf
```

## Conclusion

You can see that in just a few steps, you can use Terraform to provision the Azure VM without install terraform on the host machine!
