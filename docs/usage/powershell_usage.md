# Use PowerShell in the devops-toolkit

## Overview

PowerShell is a cross-platform task automation solution made up of a command-line shell, a scripting language, and a configuration management framework. It runs on Windows, Linux, and macOS.

## PowerShell documentation

Some resources to help you start with PowerShell:

- <https://learn.microsoft.com/en-us/powershell/>
- <https://github.com/PowerShell/PowerShell>
- <https://learn.microsoft.com/en-us/powershell/scripting/learn/ps101/01-getting-started>

## Run with Docker command

### Note

To use the existing container instead of creating one, use `docker exec` command instead of `docker run`

```bash
docker exec -it my_devops_toolkit /bin/bash
```

### Common Run Modes

For instructions on common run modes, visit [**DevOps Toolkit Common Run Mode**](../usage/run_mode.md).

### Use case 1: Start PowerShell and run basic commands

```bash
docker run --rm --network host -it tungbq/devops-toolkit:latest
###############################################
# Now we are in the docker container terminal #
###############################################
# Start PowerShell
pwsh
```

Once in PowerShell, you can run commands:

```powershell
# Check PowerShell version
$PSVersionTable

# Get current directory
Get-Location

# List files
Get-ChildItem

# Exit PowerShell
exit
```

Sample Result

```bash
root@docker-desktop:~# pwsh
PowerShell 7.6.3
PS /root> $PSVersionTable

Name                           Value
----                           -----
PSVersion                      7.6.3
PSEdition                      Core
GitCommitId                    7.6.3
OS                             Linux 5.15.167.4-microsoft-standard-WSL2 #1 SMP ...
Platform                       Unix
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0…}
PSRemotingProtocolVersion      2.3
SerializationVersion           1.1.0.1
WSManStackVersion              3.0
```

### Use case 2: Run a PowerShell script

```bash
docker run --rm --network host -it -v "$PWD:$PWD" -w "$PWD" tungbq/devops-toolkit:latest
###############################################
# Now we are in the docker container terminal #
###############################################
# Run a PowerShell script
pwsh -File ./your-script.ps1

# Or run inline PowerShell command
pwsh -Command "Get-Process | Select-Object -First 5"
```

### Use case 3: Use PowerShell with Azure

PowerShell is commonly used with Azure for cloud automation:

```bash
docker run --rm --network host -it -v ~/.dtc:/dtc tungbq/devops-toolkit:latest
###############################################
# Now we are in the docker container terminal #
###############################################
pwsh
```

In PowerShell:

```powershell
# Import Azure module (if needed)
Import-Module Az

# Connect to Azure (opens browser for authentication)
Connect-AzAccount

# List Azure subscriptions
Get-AzSubscription

# List Resource Groups
Get-AzResourceGroup
```

### Use case 4: Common PowerShell commands for DevOps

```powershell
# Working with JSON
$json = '{"name": "devops-toolkit", "version": "1.0"}' | ConvertFrom-Json
$json.name

# Working with REST APIs
Invoke-RestMethod -Uri "https://api.github.com/repos/tungbq/devops-toolkit" | Select-Object name, stargazers_count

# Environment variables
$env:PATH

# File operations
Get-Content ./README.md | Select-Object -First 10

# Process management
Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
```

## Troubleshooting

- For any issues, check [this reference](../troubleshooting/TROUBLESHOOTING.md)
