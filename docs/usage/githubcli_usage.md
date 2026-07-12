# Use GitHub CLI in the devops-toolkit

## Prerequisite

A GitHub account

## GitHub CLI document

Some document to help you start with GitHub CLI (`gh`)

- <https://cli.github.com/manual/>
- <https://docs.github.com/en/github-cli>

## Run with Docker command

### Note

To use the existing container instead of creating one, use `docker exec` command instead of `docker run`

```bash
docker exec -it my_devops_toolkit /bin/bash
```

### Common Run Modes

For instructions on common run modes, visit [**DevOps Toolkit Common Run Mode**](../usage/run_mode.md).

### Use case 1: Authenticate and list your repositories

```bash
docker run --rm --network host -it -v ~/.dtc:/dtc tungbq/devops-toolkit:latest
###############################################
# Now we are in the docker container terminal #
###############################################
# Log in (follow the device-code flow in your browser)
gh auth login
# List your repositories
gh repo list
```

Sample Result

```bash
root@docker-desktop:~# gh auth login
? What account do you want to log into? GitHub.com
? What is your preferred protocol for Git operations on this host? HTTPS
? How would you like to authenticate GitHub CLI? Login with a web browser

! First copy your one-time code: XXXX-XXXX
Press Enter to open github.com in your browser...
✓ Authentication complete.
✓ Logged in as octocat
```

### Use case 2: Work with pull requests and issues

```bash
# From inside an existing git repository
gh pr list
gh pr create --title "My change" --body "Description"
gh issue list
```

### Troubleshooting

- For any issues, check [this reference](../troubleshooting/TROUBLESHOOTING.md)
