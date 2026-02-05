# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2025-11-06

Initial release of dvm-default-sandbox — a multi-language Docker base image for the DVM (Developer Virtual Machine) secure sandbox execution environment.

### Added

**Base System**
- Ubuntu 22.04 LTS base image
- Working directory: `/workspace`
- Container runs indefinitely via `tail -f /dev/null` for exec-based control

**Languages & Runtimes**
- Node.js v24.11
- Bun runtime (latest stable)
- Python 3.11 with pip
- Go 1.22.0
- TypeScript (installed globally via npm)

**Package Managers**
- npm (included with Node.js)
- pnpm (installed globally)
- pip (Python package installer)

**Python Packages**
Pre-installed data analysis and scientific computing packages:
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

**System Tools**
- ffmpeg (multimedia processing)
- git (version control)
- curl/wget (HTTP utilities)
- unzip (archive extraction)
- build-essential (gcc, g++, make)

**CI/CD & Testing**
- Automated Docker image publishing to Docker Hub (`dvmcodes/dvm-default-sandbox`)
- Multi-platform builds (linux/amd64, linux/arm64)
- Comprehensive test suite validating all installed components
- GitHub Actions workflows for testing and publishing
- Automated GitHub Releases on version tags

**Environment Configuration**
- GOPATH configured for Go development
- Bun added to PATH
- All runtimes accessible via exec commands
- Python 3.11 set as default python/python3
