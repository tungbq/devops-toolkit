import requests
import re
from bs4 import BeautifulSoup

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
            print(f"Error fetching HTML: {e}")
            return None
    def do_http_request(self, url):
        try:
            response = requests.get(url)
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            print(f"Error fetching HTML: {e}")
            return None

    def check_python_version(self):
        latest_python_version = None
        # Define a regular expression pattern to match the version number
        pattern = r'Python (\d+\.\d+\.\d+)'
        text = self.fetch_html("https://www.python.org/downloads/")
        # Use re.search to find the first occurrence of the pattern in the text
        match = re.search(pattern, text)

        # Check if a match is found and print the version number
        if match:
            latest_python_version = match.group(1)
        else:
            print("Version number not found.")
        return latest_python_version

    def check_kubectl_version(self):
        latest_python_version = None
        # Define a regular expression pattern to match the version number
        pattern = r'v(\d+\.\d+\.\d+)'
        text = self.fetch_html("https://cdn.dl.k8s.io/release/stable.txt")
        # Use re.search to find the first occurrence of the pattern in the text
        match = re.search(pattern, text)

        # Check if a match is found and print the version number
        if match:
            latest_python_version = match.group(1)
        else:
            print("Version number not found.")
        return latest_python_version

    def check_awscli_version(self):
        latest_awscli_version = None
        # Define a regular expression pattern to match the version number
        version_pattern = re.compile(r'\b(\d+\.\d+\.\d+)\b')
        text = self.fetch_html("https://raw.githubusercontent.com/aws/aws-cli/v2/CHANGELOG.rst")
        # Search for the version number in the text
        match = version_pattern.search(text)

        # Check if a match is found and print the version number
        if match:
            latest_awscli_version = match.group(1)
            print("Parsed version number:", latest_awscli_version)
        else:
            print("Version number not found in the text.")
        return latest_awscli_version

    def check_github_release_version(self, repo, tag_prefix="v"):
        print(f"Checking repo {repo}")
        print(f"Tag prefix: {tag_prefix}")
        latest_version = None
        req = self.do_http_request(f"https://api.github.com/repos/{repo}/releases/latest")
        latest_tag_name = req["tag_name"]
        print(latest_tag_name)
        # Only get the version number
        # Default is vX.Y.Z
        latest_version =  latest_tag_name.split(tag_prefix)[1]

        print(f"Latest version of {repo}: {latest_version}")
        return latest_version

# Example usage
versions = {}
version_parser = VersionParser()
### Python
python_version = version_parser.check_python_version()
versions["python3"] = python_version

### Ansible
ansible_version = version_parser.check_github_release_version("ansible/ansible")
versions["ansible"] = ansible_version

### Terraform
terraform_version = version_parser.check_github_release_version("hashicorp/terraform")
versions["terraform"] = terraform_version

### Kubectl
kubectl_version = version_parser.check_kubectl_version()
versions["kubectl"] = kubectl_version

### Helm
helm_version = version_parser.check_github_release_version("helm/helm")
versions["helm"] = helm_version

### Awscli
awscli_version = version_parser.check_awscli_version()
versions["awscli"] = awscli_version

### AZ CLi
azcli_version = version_parser.check_github_release_version("Azure/azure-cli", "azure-cli-")
versions["azurecli"] = azcli_version

### Summary
print("Summary:")
print(versions)