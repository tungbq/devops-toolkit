# Use azurecli in the devops-toolkit

## Prerequisite

An Azure account

## azurecli document

Some document to help you start with azurecli

- <https://learn.microsoft.com/en-us/cli/azure/>

## Note

To use the existing container instead of creating one, use `docker exec` command instead of `docker run`

```bash
docker exec -it my_devops_toolkit /bin/bash
```

## Use case 1: Az login and run command

```bash
docker run --rm -it tungbq/devops-toolkit:latest

# Login with AZ CLI
az login --use-device-code
## To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code <SHOWN_IN_SCREEN> to authenticate

# List all resource groups
az group list
```

## Use case 2:  Using Azure config from the host

Mount the `.azure` folder from host when running toolkit container

```bash
docker run --rm -it -v ~/.azure:/root/.azure tungbq/devops-toolkit:latest
###############################################
# Now we are in the docker container terminal #
###############################################
# List all resource groups
az group list
```

Sample Result

```bash
➜  ~ docker run --rm -it -v ~/.azure:/root/.azure tungbq/devops-toolkit:latest
root@f097467db632:~# az group list
[
  {
    "id": "/subscriptions/xxxxxxxx-yyyy-zzzz-ttttttttt/resourceGroups/your_resource_group",
    "location": "centralindia",
    "managedBy": null,
    "name": "your_resource_group",
    "properties": {
      "provisioningState": "Succeeded"
    },
    "tags": null,
    "type": "Microsoft.Resources/resourceGroups"
  },
  ...
]
```

## Troubleshooting

- For any issues, check [this reference](../troubleshooting/TROUBLESHOOTING.md)
