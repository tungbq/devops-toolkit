#!/bin/bash

image_name=$1

# Define the tools and their expected versions
declare -A tools=(
  [python3]="3.11.8"
  [ansible]="2.16.4"
  [terraform]="1.7.4"
  [kubectl]="1.29.2"
  [helm]="3.14.2"
  [aws]="2.15.25"
  [az]="2.58.0"
  # Add more tools as needed
)

# Function to check tool versions
check_tool_version() {
  local tool_name=$1
  local expected_version=$2
  echo "[$tool_name] Checking version..."

  # Possible version option flags for different tools
  local version_flags=(
    "--version"
    "version"
  )

  installed_version=""

  # Iterate through possible version flags
  for flag in "${version_flags[@]}"; do
    installed_version=$(docker run --rm "$image_name" "$tool_name" "$flag" 2>&1)
    # Check if the version information is in the output
    if echo "$installed_version" | grep -q "$expected_version"; then
      break
    fi
  done

  # Compare the installed version with the expected version
  if echo "$installed_version" | grep -q "$expected_version"; then
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
