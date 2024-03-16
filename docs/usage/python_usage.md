# Use python in the devops-toolkit

To use the existing container isntead of creating one, use `docker exec` command instead of `docker run`

```bash
docker exec -it my_devops_toolkit /bin/bash
```

## Run python sample code provided in the container

```bash
docker run --name my_devops_toolkit --network host -it devops-toolkit:latest
# You now in the container terminal
python3 samples/python/rectangle_area_calculator.py
```

## Clone external code to container

```bash
docker run --name my_devops_toolkit --network host -it devops-toolkit:latest
# You now in the container terminal

# Clone code
mkdir python_workspace
cd python_workspace
git clone https://github.com/geekcomputers/Python.git

# Now run your cloned script
cd Python
python3 Day_of_week.py
```

## Mount external code to container

Clone the code to the host then mount to container

```bash
# Clone code on the host
docker run --name my_devops_toolkit -v "$(pwd)":/root/python_workspace --network host -it devops-toolkit:latest
# Run the python code as usual
```
