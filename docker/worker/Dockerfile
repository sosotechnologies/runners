# Base image
FROM ubuntu:24.04

# Input GitHub runner version argument
ARG RUNNER_VERSION=2.317.0
ENV DEBIAN_FRONTEND=noninteractive

# Labels
LABEL Author="Marcel L"
LABEL Email="sosotech200@gmail.com"
LABEL GitHub="https://github.com/sosotechnologies"
LABEL BaseImage="ubuntu:24.04"
LABEL RunnerVersion=${RUNNER_VERSION}

# Update and install required packages
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    curl jq ca-certificates bash && \
    rm -rf /var/lib/apt/lists/*

# Download and extract the GitHub Actions runner
RUN curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    tar xzf actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    rm actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Add the start.sh script and make it executable
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Set the entrypoint to the start.sh script
ENTRYPOINT ["/start.sh"]
# 