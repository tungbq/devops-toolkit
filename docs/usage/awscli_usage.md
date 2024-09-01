# Use awscli in the devops-toolkit

## Prerequisite

An AWS account

## awscli document

Some document to help you start with awscli

- <https://docs.aws.amazon.com/cli/>
- <https://github.com/tungbq/devops-basic/tree/main/topics/aws>


## Run with devops-toolkit-cli

### Start the container

Navigate to your workspace folder, then run:

```bash
devops-toolkit-cli init demo_awscli01
devops-toolkit-cli run demo_awscli01

# You now in the container terminal. Execute the awscli command normally
awscli --version
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

### Use case 1: Configure credentials and list S3 bucket with awscli

```bash
docker run --rm --network host -it -v ~/.dtc:/dtc tungbq/devops-toolkit:latest
###############################################
# Now we are in the docker container terminal #
###############################################
# Configure credentials
aws configure
# List S3 buckets
aws s3 ls
```

Sample Result

```bash
root@docker-desktop:~# aws configure
AWS Access Key ID [None]: xxxxxxxx
AWS Secret Access Key [None]: xxxxxxxx
Default region name [None]: xxxxxxxx
Default output format [None]: xxxxxxxx
```

### Troubleshooting

- For any issues, check [this reference](../troubleshooting/TROUBLESHOOTING.md)
