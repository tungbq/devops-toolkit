# Use kubectl in the devops-toolkit

## Kubernetes document

Some document to help you start with kubernetes (k8s)

- <https://kubernetes.io/docs/home/>
- <https://github.com/tungbq/devops-basic/tree/main/topics/k8s>

To use the existing container instead of creating one, use `docker exec` command instead of `docker run`

```bash
docker exec -it my_devops_toolkit /bin/bash
```

## Use case 1: Use kubeconfig inside container

```bash
docker run --rm --network host -it devops-toolkit:latest
# You now in the container terminal

# TODO
```

## Use case 2: Use kubeconfig from the host

```bash
# Given that we have code somewhere in you machine
docker run --rm -v "$(pwd)":/root/kubectl_workspace --network host -it devops-toolkit:latest
# Run the kubectl code as usual
# TODO
```

## Troubleshooting

- For any issues, check [this reference](../troubleshooting/TROUBLESHOOTING.md)
