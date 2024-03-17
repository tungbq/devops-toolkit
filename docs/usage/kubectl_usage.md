# Use kubectl in the devops-toolkit

## Kubernetes document

Some document to help you start with kubernetes (k8s)

- <https://kubernetes.io/docs/home/>
- <https://github.com/tungbq/devops-basic/tree/main/topics/k8s>

To use the existing container instead of creating one, use `docker exec` command instead of `docker run`

```bash
docker exec -it my_devops_toolkit /bin/bash
```

## Use case 1: Use kubeconfig from the host

Mount the `.kube/config` file from the host to container

```bash
docker run --rm --network host -it -v ~/.kube/config:/root/.kube/config devops-toolkit:latest
###############################################
# Now we are in the docker container terminal #
###############################################
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
➜  ~ docker run --rm --network host -it -v ~/.kube/config:/root/.kube/config devops-toolkit:latest
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

## Troubleshooting

- For any issues, check [this reference](../troubleshooting/TROUBLESHOOTING.md)
