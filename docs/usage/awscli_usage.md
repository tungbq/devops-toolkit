# Use awscli in the devops-toolkit

## Prerequisite

An AWS account

## awscli document

Some document to help you start with awscli

- <https://docs.aws.amazon.com/cli/>
- <https://github.com/tungbq/devops-basic/tree/main/topics/aws>

## Note

To use the existing container instead of creating one, use `docker exec` command instead of `docker run`

```bash
docker exec -it my_devops_toolkit /bin/bash
```

## Common Run Modes

For instructions on common run modes, visit [**DevOps Toolkit Common Run Mode**](../usage/run_mode.md).

## Use case 1: Configure credentials and list S3 bucket with awscli

```bash
docker run --rm --network host -it -v ~/.dtc:/config tungbq/devops-toolkit:latest
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

## Troubleshooting

- For any issues, check [this reference](../troubleshooting/TROUBLESHOOTING.md)
