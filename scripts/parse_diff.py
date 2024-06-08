import re
import subprocess
import sys

def parse_git_diff(file_path):
    # Run git diff command and capture its output
    git_diff_output = subprocess.check_output(['git', 'diff', file_path], universal_newlines=True)

    # Define regex patterns to capture the key and versions
    remove_pattern = re.compile(r'-\s+"(\w+)":\s"([\d\.]+)",')
    add_pattern = re.compile(r'\+\s+"(\w+)":\s"([\d\.]+)",')

    # Find all matches
    removed = remove_pattern.findall(git_diff_output)
    added = add_pattern.findall(git_diff_output)

    # Create dictionaries from matches for easy lookup
    removed_dict = dict(removed)
    added_dict = dict(added)

    # Generate the formatted output
    output = []
    for key in added_dict:
        if key in removed_dict:
            output.append(f"- **{key}**: from {removed_dict[key]} to {added_dict[key]}")

    formatted_output = "\n".join(output)
    return formatted_output

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <file_path>")
        sys.exit(1)

    file_path = sys.argv[1]
    formatted_output = parse_git_diff(file_path)
    print(formatted_output)
