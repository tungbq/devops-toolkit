# Security Policy

## Supported Versions

Only the most recent published image tags are supported with security fixes:

| Tag                    | Supported          |
| ----------------------- | ------------------ |
| `latest`                | :white_check_mark: |
| Most recent `vX.Y.Z` release | :white_check_mark: |
| Older releases           | :x:                 |

## Image Scanning

Every image build is scanned for OS and library vulnerabilities with [Trivy](https://github.com/aquasecurity/trivy):

- **Pull requests** that touch the `Dockerfile` are scanned before merge; the build fails on fixable `CRITICAL`/`HIGH` findings.
- **`main` and release builds** are scanned again before the image is pushed to Docker Hub, blocking publish on fixable `CRITICAL`/`HIGH` findings.
- The published `tungbq/devops-toolkit:latest` image is re-scanned on a recurring schedule to catch newly disclosed CVEs in already-shipped layers.
- All scan results are uploaded as SARIF and published to this repository's [Security tab](https://github.com/tungbq/devops-toolkit/security/code-scanning).
- A [CycloneDX SBOM](https://cyclonedx.org/) is generated for every `main` and release build and attached as a workflow artifact for supply-chain verification.
- A small number of CVEs are explicitly suppressed via [`.trivyignore`](./.trivyignore) with inline justification — currently limited to Go-module CVEs vendored inside upstream binaries (kubectl, terraform) where no release fixing them exists yet. This list is reviewed whenever those tools are version-bumped.

## Reporting a Vulnerability

If you discover a vulnerability in this repository or in a published `tungbq/devops-toolkit` image:

1. Please **do not** open a public issue for undisclosed vulnerabilities.
2. Report it privately via [GitHub Security Advisories](https://github.com/tungbq/devops-toolkit/security/advisories/new) for this repository.
3. Include the affected tag/digest, the tool and version involved, and steps to reproduce if applicable.

You should expect an initial response within a few days. Confirmed vulnerabilities will be fixed and released as soon as practical, and credited in the release notes unless you request otherwise.
