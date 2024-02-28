import os
import pytest
from docker import APIClient

# Define the path to the Dockerfile
DOCKERFILE_PATH = os.path.join(os.path.dirname(__file__), '..', 'Dockerfile')

# Define the name of the Docker image
DOCKER_IMAGE_NAME = 'test-docker-image'

# Fixture to build the Docker image before each test
@pytest.fixture(scope='function')
def build_docker_image():
    docker_client = APIClient(base_url='unix://var/run/docker.sock')
    image_id = docker_client.build(path=os.path.dirname(DOCKERFILE_PATH), dockerfile='Dockerfile', tag=DOCKER_IMAGE_NAME)
    yield image_id
    # Cleanup: Remove the Docker image after the test
    docker_client.remove_image(image_id, force=True)

# Test: Check if the Docker image was built successfully
def test_docker_image_build(build_docker_image):
    assert build_docker_image is not None

# Test: Check if Python and Ansible are installed in the Docker image
def test_python_and_ansible_installed(build_docker_image):
    docker_client = APIClient(base_url='unix://var/run/docker.sock')

    # Run a temporary container based on the built image
    container = docker_client.create_container(image=build_docker_image, command='/bin/bash', tty=True)
    docker_client.start(container=container['Id'])

    # Check if Python is installed
    exec_id = docker_client.exec_create(container=container['Id'], cmd=['python3.11', '--version'])
    exec_output = docker_client.exec_start(exec_id)
    assert b'Python 3.11' in exec_output

    # Check if Ansible is installed
    exec_id = docker_client.exec_create(container=container['Id'], cmd=['ansible', '--version'])
    exec_output = docker_client.exec_start(exec_id)
    assert b'ansible' in exec_output

    # Cleanup: Remove the temporary container
    docker_client.remove_container(container=container['Id'], force=True)
