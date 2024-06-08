import subprocess
import json
import re
import argparse

def get_git_diff(file_path):
    try:
        # Run git diff command and capture the output
        result = subprocess.run(['git', 'diff', file_path], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

        if result.returncode != 0:
            print(f"Error running git diff: {result.stderr}")
            return ""

        return result.stdout

    except Exception as e:
        print(f"An error occurred: {e}")
        return ""

def parse_diff(diff_output):
    changes = []
    lines = diff_output.splitlines()
    key_value_regex = r'^([-+])\s*"([^"]+)"\s*:\s*"([^"]+)"\s*$'

    old_values = {}
    new_values = {}

    for line in lines:
        match = re.match(key_value_regex, line)
        if match:
            operation = match.group(1)
            key = match.group(2)
            value = match.group(3)

            if operation == '-':
                old_values[key] = value
            elif operation == '+':
                new_values[key] = value

    for key in set(old_values.keys()).union(new_values.keys()):
        if key in old_values and key in new_values:
            changes.append(f'- {key}: "{old_values[key]}" -> "{new_values[key]}"')

    return changes

def main(file_path):
    diff_output = get_git_diff(file_path)
    if diff_output:
        changes = parse_diff(diff_output)
        output = {
            "Changes": changes
        }
        print(json.dumps(output, indent=2))

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Parse git diff for version changes in a JSON file.")
    parser.add_argument("file_path", help="Path to the JSON file to check for version changes.")
    args = parser.parse_args()

    main(args.file_path)
