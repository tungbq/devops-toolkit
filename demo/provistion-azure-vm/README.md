# DEMO: Provision Azure VM with DevOps toolkit

## Navigate to Terraform demo code

```bash
cd devops-toolkit/demo/provistion-azure-vm

mkdir -p $HOME/.dtc # Skip this step if you already created the configuration folder before
docker pull tungbq/devops-toolkit:latest
docker run -it --rm --name demo_azure_tf \
    -v $HOME/.dtc:/dtc \
    --network host  \
    tungbq/devops-toolkit:latest
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

## Conclusion

You can see that in just a few steps, you can use Terraform to provision the Azure VM without install terraform on the host machine!
