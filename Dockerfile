FROM ubuntu:22.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Set working directory
WORKDIR /workspace

# Install system dependencies, Node.js, Python, Go, and ffmpeg
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    unzip \
    build-essential \
    ca-certificates \
    gnupg \
    software-properties-common \
    ffmpeg \
    python3.11 \
    python3.11-dev \
    python3.11-distutils \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Set Python 3.11 as default python3
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1 \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1

# Install Node.js v24.11
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install Go
ARG GO_VERSION=1.22.0
RUN wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz \
    && rm go${GO_VERSION}.linux-amd64.tar.gz

# Set Go environment variables
ENV GOPATH=/root/go
ENV PATH=/usr/local/go/bin:${GOPATH}/bin:${PATH}

# Install TypeScript and pnpm globally
RUN npm install -g typescript pnpm

# Install Bun
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH=/root/.bun/bin:${PATH}

# Upgrade pip and install common Python data analysis packages
RUN python3 -m pip install --upgrade pip setuptools wheel && \
    python3 -m pip install --no-cache-dir \
        numpy \
        pandas \
        scipy \
        matplotlib \
        scikit-learn \
        jupyter \
        jupyterlab \
        seaborn \
        plotly \
        requests \
        beautifulsoup4 \
        lxml

# Create a fake sudo script (container runs as root)
RUN printf '#!/bin/sh\nexec "$@"\n' > /usr/bin/sudo && chmod +x /usr/bin/sudo

# Reset frontend
ENV DEBIAN_FRONTEND=

# Keep container running for exec-based usage
CMD ["tail", "-f", "/dev/null"]
