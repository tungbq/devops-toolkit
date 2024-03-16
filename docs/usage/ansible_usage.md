# Use python in the devops-toolkit

To use the existing container isntead of creating one, use `docker exec` command instead of `docker run`

```bash
docker exec -it my_devops_toolkit /bin/bash
```

## Use case 1: Run python sample code provided in the container

```bash
docker run --rm --network host -it devops-toolkit:latest
# You now in the container terminal
python3 samples/python/rectangle_area_calculator.py
```

## Use case 2: Clone external code to container

```bash
docker run --rm --network host -it devops-toolkit:latest
# You now in the container terminal

# Clone code
mkdir python_workspace
cd python_workspace
git clone https://github.com/geekcomputers/Python.git

# Now run your cloned script
cd Python
python3 Day_of_week.py
```

## Use case 3: Mount external code to container

Clone the code to the host then mount to container

```bash
# Clone code on the host
docker run --rm -v "$(pwd)":/root/python_workspace --network host -it devops-toolkit:latest
# Run the python code as usual
```

## Troubleshooting

- For any issues, check [this reference](../troubleshooting/TROUBLESHOOTING.md)
