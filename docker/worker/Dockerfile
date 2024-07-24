FROM ubuntu:24.04

ARG RUNNER_VERSION=2.317.0
ARG RUNNER_CHECKSUM="7e8e2095d2c30bbaa3d2ef03505622b883d9cb985add6596dbe2f234ece308f3"
ENV DEBIAN_FRONTEND=noninteractive

LABEL Author="cafanwi"
LABEL Email="sosotech2000@gmail.com"
LABEL GitHub="https://github.com/sosotechnologies"
LABEL BaseImage="ubuntu:20.04"
LABEL RunnerVersion=${RUNNER_VERSION}

# Update the base packages and add a non-sudo user
RUN apt-get update -y && apt-get upgrade -y && useradd -m docker

# Install packages and dependencies
RUN apt-get install -y --no-install-recommends \
    curl nodejs wget unzip vim git jq build-essential libssl-dev libffi-dev python3 python3-venv python3-dev python3-pip

# Download and setup GitHub Actions runner
RUN cd /home/docker && mkdir actions-runner && cd actions-runner && \
    curl -o actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz && \
    echo "${RUNNER_CHECKSUM}  actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz" | shasum -a 256 -c && \
    tar xzf ./actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz

# Install additional dependencies
RUN chown -R docker /home/docker && /home/docker/actions-runner/bin/installdependencies.sh

# Add and set up the start script
ADD runner-scripts/start.sh /home/docker/start.sh
RUN chmod +x /home/docker/start.sh

USER docker
ENTRYPOINT ["/home/docker/start.sh"]
