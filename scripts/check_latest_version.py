import requests
import re
import json

class VersionParser:
    def __init__(self):
        self.url = None
        self.version = None

    def fetch_html(self, url):
        try:
            response = requests.get(url)
            response.raise_for_status()
            return response.text
        except requests.exceptions.RequestException as e:
            raise Exception(f"Error fetching HTML from {url}: {e}")

    def do_http_request(self, url):
        try:
            response = requests.get(url)
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            raise Exception(f"Error fetching data from {url}: {e}")

    def check_version(self, name, url, pattern):
        latest_version = None
        text = self.fetch_html(url)
        match = re.search(pattern, text)

        if match:
            latest_version = match.group(1)
            print(f"Latest version of {name}: {latest_version}")
        else:
            raise Exception(f"Version number not found for {name}.")
        
        return latest_version

    def check_python_version(self):
        pattern = r'Python (\d+\.\d+\.\d+)'
        return self.check_version("Python", "https://www.python.org/downloads/", pattern)

    def check_kubectl_version(self):
        pattern = r'v(\d+\.\d+\.\d+)'
        return self.check_version("kubectl", "https://cdn.dl.k8s.io/release/stable.txt", pattern)

    def check_awscli_version(self):
        version_pattern = re.compile(r'\b(\d+\.\d+\.\d+)\b')
        return self.check_version("awscli", "https://raw.githubusercontent.com/aws/aws-cli/v2/CHANGELOG.rst", version_pattern)

    def check_github_release_version(self, name, repo, tag_prefix="v"):
        print(f"Checking {name} version from repo {repo} using tag prefix: {tag_prefix}")
        latest_version = None
        req = self.do_http_request(f"https://api.github.com/repos/{repo}/releases/latest")
        latest_tag_name = req["tag_name"]

        latest_version =  latest_tag_name.split(tag_prefix)[1]
        print(f"Latest version of {name}: {latest_version}")
        return latest_version

def main():
    versions = {}
    version_parser = VersionParser()

    try:
        # Python
        python_version = version_parser.check_python_version()
        versions["python3"] = python_version

        # Ansible
        ansible_version = version_parser.check_github_release_version("Ansible", "ansible/ansible")
        versions["ansible"] = ansible_version

        # Terraform
        terraform_version = version_parser.check_github_release_version("Terraform", "hashicorp/terraform")
        versions["terraform"] = terraform_version

        # Kubectl
        kubectl_version = version_parser.check_kubectl_version()
        versions["kubectl"] = kubectl_version

        # Helm
        helm_version = version_parser.check_github_release_version("Helm", "helm/helm")
        versions["helm"] = helm_version

        # Awscli
        awscli_version = version_parser.check_awscli_version()
        versions["awscli"] = awscli_version

        # AZ CLi
        azcli_version = version_parser.check_github_release_version("Azure CLI", "Azure/azure-cli", "azure-cli-")
        versions["azurecli"] = azcli_version

        # Summary
        print("Summary:")
        print(versions)

        ## TODO: implement auto workflow
        # # Write version data to 'toolkit_info.json'
        # with open('toolkit_info.json', 'w') as json_file:
        #     json.dump(versions, json_file, indent=2)
        # print("Version data written to 'toolkit_info.json'")

    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    main()
