# Use ansible in the devops-toolkit

## Ansible document

Some document to help you start with ansible

- <https://github.com/tungbq/devops-basic/tree/main/topics/ansible>
- <https://www.ansible.com/>

## Run with Docker command

### Note

To use the existing container instead of creating one, use `docker exec` command instead of `docker run`

```bash
docker exec -it my_devops_toolkit /bin/bash
```

### Common Run Modes

For instructions on common run modes, visit [**DevOps Toolkit Common Run Mode**](../usage/run_mode.md).

### Use case 1: Run Ansible sample code provided in the container

```bash
docker run --rm --network host -v ~/.dtc:/dtc -it tungbq/devops-toolkit:latest

# You now in the container terminal
ansible-playbook samples/ansible/check_os.yml
```

### Use case 2: Clone external code inside container

```bash
docker run --rm --network host -v ~/.dtc:/dtc -it tungbq/devops-toolkit:latest
# You now in the container terminal

# Now run your cloned script
# Clone code
mkdir ansible_workspace; cd ansible_workspace
git clone https://github.com/ansible/ansible-examples.git

cd ansible-examples
ansible-playbook <YOUR_PLAYBOOK_CMD>
```

### Use case 3: Mount external code to container

Clone the code to the host then mount to container

```bash
# Given that we have code somewhere in you machine
docker run --rm -v "$(pwd)":/root/ansible_workspace --network host -v ~/.dtc:/dtc -it tungbq/devops-toolkit:latest
# Run the ansible code as usual
```

### Use case 4: Mount external code to container and use .ssh keys from the host

Clone the code to the host then mount code and `.ssh` folder to container

```bash
# Given that we have code somewhere in you machine
docker run --rm -v ~/.ssh:/root/.ssh -v "$(pwd)":/root/ansible_workspace --network host -v ~/.dtc:/dtc -it tungbq/devops-toolkit:latest
# Run the ansible code as usual
```

### Troubleshooting

- For any issues, check [this reference](../troubleshooting/TROUBLESHOOTING.md)
