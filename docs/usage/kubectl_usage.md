# Use kubectl in the devops-toolkit

## Kubernetes document

Some document to help you start with kubernetes (k8s)

- <https://kubernetes.io/docs/home/>
- <https://github.com/tungbq/devops-basic/tree/main/topics/k8s>

## Run with devops-toolkit-cli

### Start the container

Navigate to your workspace folder, then run:

```bash
devops-toolkit-cli init demo_kubectl01
devops-toolkit-cli run demo_kubectl01

# You now in the container terminal. Execute the kubectl command normally
kubectl --version
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

### Use case 1: Use kube config from the host

Mount the `.kube/config` file from the host to container

```bash
docker run --rm --network host -it -v ~/.dtc:/dtc tungbq/devops-toolkit:latest
###############################################
# Now we are in the docker container terminal #
###############################################
# Command to check k8s node
kubectl get nodes
# Deploy application
kubectl apply -f https://k8s.io/examples/application/deployment.yaml
# View the pod
kubectl get pods -w
# View the deployment
kubectl get deployment
# More command as per your need...
```

Sample Result

```bash
root@docker-desktop:~# kubectl get nodes
NAME                 STATUS   ROLES           AGE   VERSION
kind-control-plane   Ready    control-plane   21m   v1.29.2
root@docker-desktop:~# kubectl apply -f https://k8s.io/examples/application/deployment.yaml
deployment.apps/nginx-deployment unchanged
root@docker-desktop:~# kubectl get pods -w
NAME                                READY   STATUS    RESTARTS   AGE
nginx-deployment-86dcfdf4c6-c2cfp   1/1     Running   0          99s
nginx-deployment-86dcfdf4c6-w4vp7   1/1     Running   0          99s
root@docker-desktop:~# kubectl get deployment
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   2/2     2            2           115s
```

### Troubleshooting

- For any issues, check [this reference](../troubleshooting/TROUBLESHOOTING.md)
