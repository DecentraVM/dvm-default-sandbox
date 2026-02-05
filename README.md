# DVM Default Sandbox

## Quick Start

Pull and run the latest stable image:

```bash
docker pull dvmcodes/dvm-default-sandbox:latest
docker run -d --name dvm-sandbox dvmcodes/dvm-default-sandbox:latest
```

Execute commands in the running container:

```bash
# Python
docker exec dvm-sandbox python3 -c "print('Hello from Python')"

# Node.js
docker exec dvm-sandbox node -e "console.log('Hello from Node.js')"

# Interactive shell
docker exec -it dvm-sandbox /bin/bash
```

## What's Included

### Programming Languages and Runtimes

- Node.js v24.11
- Bun (latest stable)
- Python 3.11
- Go 1.22.0
- TypeScript (installed globally)

### Package Managers

- npm (included with Node.js)
- pnpm (fast, disk-efficient package manager)
- pip (Python package installer)

### Python Data Science Stack

Pre-installed packages for data analysis and machine learning:

- numpy
- pandas
- scipy
- matplotlib
- seaborn
- plotly
- scikit-learn
- jupyter
- jupyterlab
- requests
- beautifulsoup4
- lxml

### System Tools

- ffmpeg
- git
- curl
- wget
- build-essential (gcc, g++, make)
- unzip

### Base System

- Ubuntu 22.04 LTS
- Working Directory: /workspace
- Multi-platform: linux/amd64, linux/arm64

## Available Tags

- latest - Latest stable release
- v1, v1.0, v1.0.0 - Versioned releases
- edge - Latest development build (unstable)

## Usage Examples

### Running the Container

```bash
docker run -d --name dvm-sandbox dvmcodes/dvm-default-sandbox:latest
docker run -d --name dvm-sandbox dvmcodes/dvm-default-sandbox:v1.0.0
```

### Executing Commands

```bash
docker exec dvm-sandbox node --version
docker exec dvm-sandbox python3 --version
docker exec dvm-sandbox go version
docker exec dvm-sandbox bun --version

docker exec dvm-sandbox python3 -c "import pandas; print(pandas.__version__)"
docker exec dvm-sandbox node -e "console.log(process.version)"
docker exec dvm-sandbox pnpm --version
```

### Interactive Development

```bash
docker exec -it dvm-sandbox /bin/bash
docker exec -it dvm-sandbox python3
docker exec -it dvm-sandbox node
```

### With Mounted Volumes

```bash
docker run -d --name dvm-sandbox \
  -v $(pwd):/workspace/code \
  dvmcodes/dvm-default-sandbox:latest

docker exec dvm-sandbox python3 /workspace/code/script.py
```

## Container Characteristics

This image is designed for the DVM execution environment with the following characteristics:

- Runs indefinitely using tail -f /dev/null
- Default user is root
- Stateless by default (use volumes for persistence)
- Works on amd64 and arm64 architectures

## Environment Variables

- GOPATH=/root/go
- PATH includes Node.js, Bun, Go, and npm global binaries

## Platform and Registry

- Docker Hub: dvmcodes/dvm-default-sandbox
- Platform: https://dvm.codes
- Source: https://github.com/dvm-codes/dvm-default-sandbox
- Changelog: CHANGELOG.md

## License

This project is the official reference image for the DVM (Decentralized Virtual Machine) platform.
