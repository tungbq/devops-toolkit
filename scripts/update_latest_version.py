import json
import argparse

def parse_toolkit_info(toolkit_info_file):
    with open(toolkit_info_file, 'r') as json_file:
        toolkit_info = json.load(json_file)
    return toolkit_info

def update_dockerfile(dockerfile_path, version_arg, new_version):
    with open(dockerfile_path, 'r') as file:
        dockerfile_content = file.read()

    old_version = None
    arg_pattern = f'{version_arg}='
    if arg_pattern in dockerfile_content:
        old_version = dockerfile_content.split(arg_pattern)[1].split()[0]

    print(f"Old version: {old_version}")
    if not old_version:
        raise Exception("Cannot detect old version!")

    if old_version != new_version:
        new_dockerfile_content = dockerfile_content.replace(f'{arg_pattern}{old_version}', f'{arg_pattern}{new_version}')

        with open(dockerfile_path, 'w') as file:
            file.write(new_dockerfile_content)

        print(f"Dockerfile updated. {tool_name} version changed from {old_version} to {new_version}")
    else:
        print(f"No update needed for {tool_name}. Versions match.")

def update_readme(readme_path, version_arg, new_version):
    print(f"Working on: {readme_path}")
    with open(readme_path, 'r') as file:
        dockerfile_content = file.read()

    old_version = None
    arg_pattern = f'| {version_arg}='
    if arg_pattern in dockerfile_content:
        old_version = dockerfile_content.split(arg_pattern)[1].split()[0]

    print(f"Old version: {old_version}")
    if not old_version:
        raise Exception("Cannot detect old version!")

    if old_version != new_version:
        new_dockerfile_content = dockerfile_content.replace(f'{arg_pattern}{old_version}', f'{arg_pattern}{new_version}')

        with open(readme_path, 'w') as file:
            file.write(new_dockerfile_content)

        print(f"readme_path updated. {tool_name} version changed from {old_version} to {new_version}")
    else:
        print(f"No update needed for {tool_name}. Versions match.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Update Dockerfile with latest toolkit versions.")
    parser.add_argument("toolkit_info", help="Path to the toolkit_info.json file")
    parser.add_argument("dockerfile", help="Path to the Dockerfile")
    parser.add_argument("readme", help="Path to the readme")

    args = parser.parse_args()

    toolkit_info_file = args.toolkit_info
    dockerfile_path = args.dockerfile
    readme_path = args.readme

    toolkit_info = parse_toolkit_info(toolkit_info_file)

    tools = [
        {"name": "python3", "version_arg": "PYTHON_VERSION"},
        {"name": "ansible", "version_arg": "ANSIBLE_VERSION"},
        {"name": "terraform", "version_arg": "TERRAFORM_VERSION"},
        {"name": "kubectl", "version_arg": "KUBECTL_VERSION"},
        {"name": "helm", "version_arg": "HELM_VERSION"},
        {"name": "awscli", "version_arg": "AWSCLI_VERSION"},
        {"name": "azurecli", "version_arg": "AZURECLI_VERSION"}
    ]

    for tool in tools:
        tool_name = tool["name"]
        version_arg = tool["version_arg"]

        if tool_name in toolkit_info:
            new_version = toolkit_info[tool_name]
            update_dockerfile(dockerfile_path, version_arg, new_version)
            update_readme(readme_path, version_arg, new_version)
        else:
            print(f"Error: {tool_name} version not found in {toolkit_info_file}.")
