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

# Example usage
versions = {}

version_parser = VersionParser()
latest_version = version_parser.check_python_version()

if latest_version:
    print(f"Latest Python version: {latest_version}")
else:
    print("Failed to retrieve the latest version.")

versions["python3"] = latest_version


print(versions)