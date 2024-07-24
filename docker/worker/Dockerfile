FROM ubuntu:22.04

# Define the runner version and checksum
ARG RUNNER_VERSION=2.304.0
ARG RUNNER_CHECKSUM=9e883d210df8c6028aff475475a457d380353f9d01877d51cc01a17b2a91161d

# Update and install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    sudo \
    git \
    libicu-dev \
    libkrb5-3 \
    zlib1g \
    libssl-dev \
    ca-certificates \
    nodejs \
    npm && \
    rm -rf /var/lib/apt/lists/*

# Download and setup GitHub Actions runner
RUN cd /home && mkdir docker && cd docker && mkdir actions-runner && cd actions-runner && \
    curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    echo "${RUNNER_CHECKSUM}  actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz" | sha256sum -c && \
    tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Add remaining Dockerfile steps here...


# Install additional dependencies
RUN chown -R docker:docker /home/docker && /home/docker/actions-runner/bin/installdependencies.sh

# Add and set up the start script
ADD runner-scripts/start.sh /home/docker/start.sh
RUN chmod +x /home/docker/start.sh

USER docker
ENTRYPOINT ["/home/docker/start.sh"]
