# Release Guide for v1.0.0

## Pre-Release Checklist

### Files Ready for v1.0.0

- [x] Dockerfile - Multi-language base image configured
- [x] README.md - Complete documentation with Docker references
- [x] CHANGELOG.md - v1.0.0 dated 2025-11-06
- [x] test.sh - Comprehensive test suite
- [x] .gitignore - Proper exclusions
- [x] .github/workflows/test.yml - CI for testing and edge builds
- [x] .github/workflows/publish.yml - Automated publishing on version tags

### Required Setup

Before creating the v1.0.0 release, ensure these GitHub repository secrets exist:

1. Repository Settings -> Secrets and variables -> Actions
2. Add the following secrets:
   - DOCKERHUB_USERNAME = dvmcodes
   - DOCKERHUB_TOKEN = Docker Hub access token

Creating a Docker Hub Access Token:
1. Log in to Docker Hub
2. Go to Account Settings -> Security -> New Access Token
3. Name it (example: github-actions-dvm-sandbox)
4. Copy the token and save it as DOCKERHUB_TOKEN

### Release Contents

Version: 1.0.0  
Release Date: 2025-11-06  
Docker Image: dvmcodes/dvm-default-sandbox

#### Included Software

Base System:
- Ubuntu 22.04 LTS

Languages and Runtimes:
- Node.js 24.11
- Bun (latest stable)
- Python 3.11
- Go 1.22.0
- TypeScript (global)

Package Managers:
- npm
- pnpm
- pip

Pre-installed Python Packages:
- numpy
- pandas
- scipy
- matplotlib
- scikit-learn
- jupyter
- jupyterlab
- seaborn
- plotly
- requests
- beautifulsoup4
- lxml

System Tools:
- ffmpeg
- git
- curl
- wget
- unzip
- build-essential

Platform Support:
- linux/amd64
- linux/arm64

## Release Process

### Step 1: Verify Everything Is Committed

```bash
git status
git add .
git commit -m "Prepare for v1.0.0 release"
git push origin main
```

### Step 2: Create and Push the Tag

```bash
git tag -a v1.0.0 -m "Release v1.0.0 - Initial stable release"
git push origin v1.0.0
```

### Step 3: Monitor GitHub Actions

1. Open the Actions tab in GitHub
2. Watch the "Publish Docker Image" workflow
3. The workflow will:
   - Run the test suite
   - Build multi-arch images
   - Push tags: v1.0.0, v1, latest
   - Create a GitHub Release

### Step 4: Verify the Release

Check Docker Hub:

```bash
docker pull dvmcodes/dvm-default-sandbox:v1.0.0
docker pull dvmcodes/dvm-default-sandbox:latest

docker run -d --name test-sandbox dvmcodes/dvm-default-sandbox:v1.0.0
docker exec test-sandbox node --version
docker exec test-sandbox bun --version
docker exec test-sandbox python3 --version
docker exec test-sandbox go version
docker stop test-sandbox
docker rm test-sandbox
```

Check GitHub Release:
- Confirm v1.0.0 exists in the Releases page

Check Docker Hub:
- Confirm tags: v1.0.0, v1, latest

## Post-Release

Prepare CHANGELOG.md for future work:

```markdown
## [Unreleased]

### Added

### Changed

### Fixed

## [1.0.0] - 2025-11-06
```

## Rollback

If needed:

```bash
git tag -d v1.0.0
git push origin :refs/tags/v1.0.0
```

Then remove:
- GitHub Release
- Docker Hub tags

Fix issues and re-release.

## Available Image Tags

- dvmcodes/dvm-default-sandbox:latest
- dvmcodes/dvm-default-sandbox:v1
- dvmcodes/dvm-default-sandbox:v1.0.0
- dvmcodes/dvm-default-sandbox:edge
- dvmcodes/dvm-default-sandbox:sha-COMMIT

## Testing the Release

```bash
docker pull dvmcodes/dvm-default-sandbox:v1.0.0
docker run -d --name dvm-sandbox dvmcodes/dvm-default-sandbox:v1.0.0

docker exec dvm-sandbox node --version
docker exec dvm-sandbox bun --version
docker exec dvm-sandbox python3 --version
docker exec dvm-sandbox go version
docker exec dvm-sandbox tsc --version
docker exec dvm-sandbox pnpm --version

docker stop dvm-sandbox
docker rm dvm-sandbox
```

## Support

- Documentation: README.md
- Changelog: CHANGELOG.md
- Issues: https://github.com/dvmcodes/dvm-default-sandbox/issues
- Docker Hub: https://hub.docker.com/r/dvmcodes/dvm-default-sandbox
