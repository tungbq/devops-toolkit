#!/bin/bash

image_name=$1
toolkit_info_path=$2

# Use jq to extract values
python_version=$(cat "$toolkit_info_path" | jq -r '.python3')
ansible_version=$(cat "$toolkit_info_path" | jq -r '.ansible')
terraform_version=$(cat "$toolkit_info_path" | jq -r '.terraform')
kubectl_version=$(cat "$toolkit_info_path" | jq -r '.kubectl')
helm_version=$(cat "$toolkit_info_path" | jq -r '.helm')
awscli_version=$(cat "$toolkit_info_path" | jq -r '.awscli')
azurecli_version=$(cat "$toolkit_info_path" | jq -r '.azurecli')

# Print the versions
echo "Desired version:"
echo "python_version=$python_version"
echo "ansible_version=$ansible_version"
echo "terraform_version=$terraform_version"
echo "kubectl_version=$kubectl_version"
echo "helm_version=$helm_version"
echo "awscli_version=$awscli_version"
echo "azurecli_version=$azurecli_version"

# Define the tools and their expected versions
declare -A tools=(
  [python3]="$python_version"
  [ansible]="$ansible_version"
  [terraform]="$terraform_version"
  [kubectl]="$kubectl_ve"rsion
  [helm]="$helm_version"
  [aws]="$awscli_version"
  [az]="$azurecli_version"
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
