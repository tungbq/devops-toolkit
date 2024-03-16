# Use ansible in the devops-toolkit

To use the existing container isntead of creating one, use `docker exec` command instead of `docker run`

```bash
docker exec -it my_devops_toolkit /bin/bash
```

## Use case 1: Run Ansible sample code provided in the container

```bash
docker run --rm --network host -it devops-toolkit:latest

# You now in the container terminal
ansible-playbook samples/ansible/check_os.yml
```

## Use case 2: Clone external code to container

```bash
docker run --rm --network host -it devops-toolkit:latest
# You now in the container terminal

# Now run your cloned script
# Clone code
mkdir ansible_workspace
cd ansible_workspace
git clone https://github.com/ansible/ansible-examples.git

cd ansible-examples
ansible-playbook <YOUR_PLAYBOOK_CMD>
```

## Use case 3: Mount external code to container

Clone the code to the host then mount to container

```bash
# Clone code on the host
docker run --rm -v "$(pwd)":/root/ansible_workspace --network host -it devops-toolkit:latest
# Run the ansible code as usual
```

## Troubleshooting

- For any issues, check [this reference](../troubleshooting/TROUBLESHOOTING.md)
