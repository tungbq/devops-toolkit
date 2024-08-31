# Use python in the devops-toolkit

## Python document

Some document to help you start with python

- <https://www.python.org/doc/>
- <https://github.com/tungbq/devops-basic/tree/main/topics/python>

## Run with devops-toolkit-cli

### Start the container

Navigate to your workspace folder, then run:

```bash
devops-toolkit-cli init
devops-toolkit-cli run

# You now in the container terminal. Execute the python command normally
python3 --version
```

It will mount the workspace code to container and you then can execute desired scripts inside the `devops-toolkit` container

## Run with Docker command

### Note

To use the existing container instead of creating one, use `docker exec` command instead of `docker run`

```bash
# Given that we have 'my_devops_toolkit' start before
docker exec -it my_devops_toolkit /bin/bash
```

### Common Run Modes

For instructions on common run modes, visit [**DevOps Toolkit Common Run Mode**](../usage/run_mode.md).

### Use case 1: Run python sample code provided in the container

```bash
docker run --rm --network host -it -v ~/.dtc:/dtc tungbq/devops-toolkit:latest
  # You now in the container terminal
python3 samples/python/rectangle_area_calculator.py
```

### Use case 2: Clone external code inside container

```bash
docker run --rm --network host -it -v ~/.dtc:/dtc tungbq/devops-toolkit:latest
# You now in the container terminal
# Clone code
mkdir python_workspace
cd python_workspace

# Clone code
mkdir python_workspace; cd python_workspace
git clone https://github.com/geekcomputers/Python.git

# Now run your cloned script
cd Python
python3 Day_of_week.py
```

### Use case 3: Mount external code to container

Clone the code to the host then mount to container

```bash
# Given that we have code somewhere in you machine
docker run --rm -v "$(pwd)":/root/python_workspace --network host -it -v ~/.dtc:/dtc tungbq/devops-toolkit:latest
# Run the python code as usual
```

### Troubleshooting

- For any issues, check [this reference](../troubleshooting/TROUBLESHOOTING.md)
