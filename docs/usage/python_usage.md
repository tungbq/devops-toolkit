# Use python in the devops-toolkit

## Python document

Some document to help you start with python

- <https://www.python.org/doc/>
- <https://github.com/tungbq/devops-basic/tree/main/topics/python>

## Note

To use the existing container instead of creating one, use `docker exec` command instead of `docker run`

```bash
# Given that we have 'my_devops_toolkit' start before
docker exec -it my_devops_toolkit /bin/bash
```

## Use case 1: Run python sample code provided in the container

```bash
docker run --rm --network host -it tungbq/devops-toolkit:latest
  # You now in the container terminal
python3 samples/python/rectangle_area_calculator.py
```

## Use case 2: Clone external code inside container

```bash
docker run --rm --network host -it tungbq/devops-toolkit:latest
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

## Use case 3: Mount external code to container

Clone the code to the host then mount to container

```bash
# Given that we have code somewhere in you machine
docker run --rm -v "$(pwd)":/root/python_workspace --network host -it tungbq/devops-toolkit:latest
# Run the python code as usual
```

## Troubleshooting

- For any issues, check [this reference](../troubleshooting/TROUBLESHOOTING.md)
