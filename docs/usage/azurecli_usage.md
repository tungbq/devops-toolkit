# Use azurecli in the devops-toolkit

## Prerequisite

An Azure account

## azurecli document

Some document to help you start with azurecli

- <https://learn.microsoft.com/en-us/cli/azure/>

## Run with devops-toolkit-cli

### Start the container

Navigate to your workspace folder, then run:

```bash
devops-toolkit-cli init demo_azcli01
devops-toolkit-cli run demo_azcli01

# You now in the container terminal. Execute the az command normally
az --version
```

It will mount the workspace code to container and you then can execute desired scripts inside the `devops-toolkit` container.

## Run with Docker command

### Note

To use the existing container instead of creating one, use `docker exec` command instead of `docker run`

```bash
docker exec -it my_devops_toolkit /bin/bash
```

### Common Run Modes

For instructions on common run modes, visit [**DevOps Toolkit Common Run Mode**](../usage/run_mode.md).

### Use case 1: Az login and run command

```bash
docker run --rm -it -v ~/.dtc:/dtc tungbq/devops-toolkit:latest

# Login with AZ CLI
az login --use-device-code
### To sign in, use a web browser to open the page https://microsoft.com/devicelogin and enter the code <SHOWN_IN_SCREEN> to authenticate

# List all resource groups
az group list
```

Sample Result

```bash
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

### Troubleshooting

- For any issues, check [this reference](../troubleshooting/TROUBLESHOOTING.md)
