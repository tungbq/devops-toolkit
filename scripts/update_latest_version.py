import json
import argparse
import os

def parse_toolkit_info(toolkit_info_file):
    with open(toolkit_info_file, 'r') as json_file:
        toolkit_info = json.load(json_file)
    return toolkit_info

def update_file(file_path, version_arg, new_version, file_type):
    with open(file_path, 'r') as file:
        file_content = file.read()

    old_version = None
    arg_pattern = f'{version_arg}=' if file_type == 'Dockerfile' else f'| {version_arg}='
    if arg_pattern in file_content:
        old_version = file_content.split(arg_pattern)[1].split()[0]

    print(f"Working on: {file_path}")
    print(f"Old version: {old_version}")

    if not old_version:
        raise Exception(f"Cannot detect old version in {file_type}!")

    if old_version != new_version:
        new_file_content = file_content.replace(f'{arg_pattern}{old_version}', f'{arg_pattern}{new_version}')

        with open(file_path, 'w') as file:
            file.write(new_file_content)

        print(f"{file_type} updated. {tool_name} version changed from {old_version} to {new_version}")
    else:
        print(f"No update needed for {tool_name}. Versions match.")

def update_dockerfile(dockerfile_path, version_arg, new_version):
    update_file(dockerfile_path, version_arg, new_version, 'Dockerfile')

def update_readme(readme_path, version_arg, new_version):
    update_file(readme_path, version_arg, new_version, 'readme')

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
        {"name": "azurecli", "version_arg": "AZURECLI_VERSION"},
        {"name": "pwsh", "version_arg": "PS_VERSION"}
    ]

    for tool in tools:
        tool_name = tool["name"]
        print(f"[{tool_name}] Check and update")
        version_arg = tool["version_arg"]

        if tool_name in toolkit_info:
            new_version = toolkit_info[tool_name]
            update_dockerfile(dockerfile_path, version_arg, new_version)
            update_readme(readme_path, version_arg, new_version)
        else:
            print(f"Error: {tool_name} version not found in {toolkit_info_file}.")
