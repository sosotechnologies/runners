# Base image
FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

# Set the GitHub runner version
ARG RUNNER_VERSION="2.280.3"

# Update the base packages
RUN apt-get update -y && apt-get upgrade -y

# Install dependencies
RUN apt-get install -y --no-install-suggests --no-install-recommends \
    curl \
    ca-certificates \
    jq \
    libssl-dev \
    libffi-dev \
    python3 \
    python3-venv \
    python3-dev \
    build-essential

# Create a directory for the GitHub Actions runner
RUN mkdir -p /home/docker/actions-runner
WORKDIR /home/docker/actions-runner

# Download the latest runner package
RUN curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Install dependencies for the runner
RUN /home/docker/actions-runner/bin/installdependencies.sh

# Copy the start script
COPY start.sh /home/docker/actions-runner/start.sh

# Make the start script executable
RUN chmod +x /home/docker/actions-runner/start.sh

# Set the entrypoint to the start script
ENTRYPOINT ["/home/docker/actions-runner/start.sh"]



# FROM ubuntu:20.04

# RUN apt-get update && apt-get install -y \
#     curl \
#     jq \
#     git \
#     sudo \
#     bash \
#     unzip \
#     libcurl4-openssl-dev \
#     libssl-dev \
#     libunwind8 \
#     netcat \
#     ca-certificates \
#     apt-transport-https \
#     software-properties-common

# RUN mkdir /actions-runner
# WORKDIR /actions-runner

# RUN curl -o actions-runner-linux-x64-2.317.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.317.0/actions-runner-linux-x64-2.317.0.tar.gz

# RUN echo "9e883d210df8c6028aff475475a457d380353f9d01877d51cc01a17b2a91161d  actions-runner-linux-x64-2.317.0.tar.gz" | shasum -a 256 -c

# RUN tar xzf ./actions-runner-linux-x64-2.317.0.tar.gz

# COPY entrypoint.sh /entrypoint.sh

# RUN chmod +x /entrypoint.sh

# COPY runner.sh /runner.sh

# RUN chmod +x /runner.sh

# ENTRYPOINT ["/entrypoint.sh"]
