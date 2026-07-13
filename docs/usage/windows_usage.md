# Use devops-toolkit on Windows (PowerShell host)

## Overview

This guide is for Windows users running commands from a PowerShell host - either
Windows PowerShell 5.1 (built into Windows) or PowerShell 7+ (`pwsh`) - who want
to run the devops-toolkit container.

Most examples elsewhere in this repo (README, [run_mode.md](./run_mode.md), the
other `*_usage.md` docs) are written for a Bash host shell. This page translates
them to PowerShell syntax.

> Looking for how to use PowerShell (`pwsh`) *inside* the running container
> instead? See [powershell_usage.md](./powershell_usage.md).

## Prerequisite

- [Docker Desktop for Windows](https://docs.docker.com/desktop/install/windows-install/), with the WSL2 backend enabled (recommended)
- Windows PowerShell 5.1 (built into Windows) or [PowerShell 7+](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows)

## Key differences from the Bash examples in this repo

1. **Line continuation**: PowerShell uses a backtick (`` ` ``) at the end of a
   line instead of Bash's backslash (`\`).
2. **Current directory**: use `${PWD}` instead of Bash's `$PWD` - PowerShell
   interpolates it to the same plain path string (e.g. `C:\Users\you\project`).
3. **Home directory**: `$HOME` works the same in PowerShell as in Bash (both
   Windows PowerShell 5.1 and PowerShell 7+ define it) - `$env:USERPROFILE` is
   the classic Windows equivalent if you prefer it.
4. **Mounting a Windows path into the Linux container**: pick a plain Linux-side
   mount point like `/workspace` rather than mirroring the Windows path on both
   sides of `-v` - a container path like `C:\Users\you\project` is legal but
   awkward, since Linux has no concept of drive letters.

## Run with Docker command

### Use case 1: Quick start

```powershell
New-Item -ItemType Directory -Force "$HOME\.dtc" | Out-Null   # Skip if you already created the configuration folder before
docker pull tungbq/devops-toolkit:latest
docker run -it --rm --name devops-toolkit-demo1 `
    -v "${HOME}\.dtc:/dtc" `
    --network host `
    tungbq/devops-toolkit:latest
```

### Use case 2: Mount the current directory and a config folder

```powershell
docker run -it --name devops-toolkit-demo2 `
    --volume "${PWD}:/workspace" `
    --volume "${HOME}\.dtc:/dtc" `
    --volume "${HOME}\.ssh:/root/.ssh" `
    --workdir /workspace `
    --network host `
    tungbq/devops-toolkit:latest

# Adjust the docker run command based on your use case
```

### Use case 3: Mount individual tool configs from the host

```powershell
docker run -it --name devops-toolkit-demo3 `
    --volume "${HOME}\.aws:/root/.aws" `
    --volume "${HOME}\.azure:/root/.azure" `
    --volume "${HOME}\.kube:/root/.kube" `
    --volume "${HOME}\.terraform.d:/root/.terraform.d" `
    --volume "${HOME}\.config\helm:/root/.config/helm" `
    --volume "${HOME}\.ansible:/root/.ansible" `
    --volume "${HOME}\.gitconfig:/root/.gitconfig" `
    --volume "${HOME}\.ssh:/root/.ssh" `
    --volume "${PWD}:/workspace" `
    --workdir /workspace `
    --network host `
    tungbq/devops-toolkit:latest

# Adjust the docker run command based on your use case
```

### Use case 4: Attach to an already-running container

```powershell
docker exec -it my_devops_toolkit /bin/bash
```

Sample Result

```text
PS C:\Users\you> docker run -it --rm --name devops-toolkit-demo1 -v "${HOME}\.dtc:/dtc" --network host tungbq/devops-toolkit:latest
Custom configuration directory detected. Setting up symlinks...
root@a1b2c3d4e5f6:~#
```

### Note

- Common run options (interactive mode, container naming, keeping vs. removing
  the container, etc.) are the same as documented in
  [run_mode.md](./run_mode.md) - only the PowerShell line-continuation and path
  syntax above change.
- `--network host` needs Docker Desktop 4.34+ with host networking enabled
  (Settings → Resources → Network). If it's unavailable in your version, drop
  the flag and either publish ports explicitly (`-p HOST_PORT:CONTAINER_PORT`)
  or, from inside the container, reach services on the host via
  `host.docker.internal` instead of `localhost`.
- Once inside the container you land in a `bash` shell by default. `pwsh` is
  also installed - see [powershell_usage.md](./powershell_usage.md) for using
  PowerShell *inside* the container.

## Troubleshooting

- For any issues, check [this reference](../troubleshooting/TROUBLESHOOTING.md)
