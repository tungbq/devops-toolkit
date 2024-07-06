# DevOps toolkit run mode

The DevOps Toolkit image can be run in various modes. See [docker/container/run](https://docs.docker.com/reference/cli/docker/container/run/) for more information. Check the document below for further details.

## Run option

Command: `docker run <RUN_OPTS> tungbq/devops-toolkit:<TAG>`, some of the common options can be used in any combination:

- `-it`: Interactive mode.
- `--rm`: Remove the container after it completes (Ctrl + C or container exit event).
- `--network host`: Use the host (VM) network.
- `--name <CONTAINER_NAME>`: Assign a name to the container (e.g: `--name demo001`).
- `-v <ABS_PATH_ON_THE_HOST>:/config`: Mount a config folder on the host to the container. This allows reusing configurations in the container, like AWS and Azure login sessions (e.g: `-v ~/.devops-toolkit-config:/config`, `-v /tmp/devops-toolkit-config-01:/config`).

## Example

- Run the image in interactive mode:

```bash
docker run -it --rm tungbq/devops-toolkit:latest
```

- Run a specific tag of the toolkit:

```bash
docker run -it --rm tungbq/devops-toolkit:0.1.0
```

- Run the image with host network and remove the container after it completes:

```bash
docker run --network host -it --rm tungbq/devops-toolkit:latest
```

- Run the image with default configuration and keep the container:

```bash
docker run --network host -it tungbq/devops-toolkit:latest
```

- Run the image with default configuration, specify the container name, and keep the container:

```bash
docker run --network host -it --name demo001 tungbq/devops-toolkit:latest
```

- Run the image and mount the configuration from the host, and remove the container after it completes:

```bash
mkdir -p ~/.devops-toolkit-config # or other location you want to store the configuration
docker run --network host -it --rm -v ~/.devops-toolkit-config:/config tungbq/devops-toolkit:latest
```
