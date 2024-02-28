#!/bin/bash

image_name=$1

# Define the tools and their expected versions
declare -A tools=(
  [python3]="3.11.3"
  [ansible]="2.16.4"
  [terraform]="1.7.4"
  # Add more tools as needed
)

# Function to check tool versions
check_tool_version() {
  local tool_name=$1
  local expected_version=$2
  echo "[$tool_name] Checking version..."
  # Get the installed version
  installed_version=$(docker run --rm $image_name $tool_name --version)
  echo "$installed_version"
  # Compare the installed version with the expected version
  if [[ "$installed_version" == *"$expected_version"* ]]; then
    echo "[OK] $tool_name version is correct: $installed_version"
  else
    echo "[Error] Incorrect $tool_name version. Expected $expected_version but found $installed_version"
    exit 1
  fi
}

# Loop through the tools and check their versions
for tool in "${!tools[@]}"; do
  check_tool_version "$tool" "${tools[$tool]}"
  echo ""
done

# If all checks pass, print success message
echo "All tools in $image_name are correctly installed and have the expected versions."
