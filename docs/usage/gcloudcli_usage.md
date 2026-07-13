# Use gcloudcli in the devops-toolkit

## Prerequisite

A Google Cloud account

## gcloudcli document

Some document to help you start with the Google Cloud CLI

- <https://cloud.google.com/sdk/gcloud/reference>

## Run with Docker command

### Note

To use the existing container instead of creating one, use `docker exec` command instead of `docker run`

```bash
docker exec -it my_devops_toolkit /bin/bash
```

### Common Run Modes

For instructions on common run modes, visit [**DevOps Toolkit Common Run Mode**](../usage/run_mode.md).

### Use case 1: gcloud login and run command

```bash
docker run --rm -it -v ~/.dtc:/dtc tungbq/devops-toolkit:latest

# Login with gcloud CLI
gcloud auth login --no-launch-browser
### Copy the printed URL into a browser, sign in, then paste the verification code back into the terminal

# Set the active project
gcloud config set project <YOUR_PROJECT_ID>

# List Compute Engine instances
gcloud compute instances list
```

Sample Result

```bash
root@f097467db632:~# gcloud projects list
PROJECT_ID       NAME          PROJECT_NUMBER
your-project-id  your-project  123456789012
```

### Troubleshooting

- For any issues, check [this reference](../troubleshooting/TROUBLESHOOTING.md)
