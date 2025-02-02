# Use helm in the devops-toolkit

## Prerequisite

Familiar with the [kubectl_usage](./kubectl_usage.md) first so we can have the correct k8s integration

## Helm document

Some document to help you start with helm

- <https://helm.sh/docs/>
- <https://github.com/tungbq/devops-basic/tree/main/topics/helm>

## Run with Docker command

### Note

To use the existing container instead of creating one, use `docker exec` command instead of `docker run`

```bash
docker exec -it my_devops_toolkit /bin/bash
```

### Common Run Modes

For instructions on common run modes, visit [**DevOps Toolkit Common Run Mode**](../usage/run_mode.md).

### Use case 1: Deploy an application with Helm

```bash
docker run --rm --network host -it -v ~/.dtc:/dtc tungbq/devops-toolkit:latest
###############################################
# Now we are in the docker container terminal #
###############################################
# Command to check k8s node
kubectl get nodes
# Deploy with Helm
helm repo add bitnami https://charts.bitnami.com/bitnami
# Make sure we get the latest list of charts
helm repo update
helm install bitnami/mysql --generate-name
```

Sample Result

```bash
Update Complete. ⎈Happy Helming!⎈
root@docker-desktop:~# helm install bitnami/mysql --generate-name
WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /root/.kube/config
WARNING: Kubernetes configuration file is world-readable. This is insecure. Location: /root/.kube/config
NAME: mysql-1710654490
LAST DEPLOYED: Sun Mar 17 05:48:12 2024
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: mysql
CHART VERSION: 9.23.0
APP VERSION: 8.0.36
```

### Troubleshooting

- For any issues, check [this reference](../troubleshooting/TROUBLESHOOTING.md)
