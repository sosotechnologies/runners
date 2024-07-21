FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
  curl \
  jq \
  git \
  docker.io

WORKDIR /runner

COPY runner.sh entrypoint.sh ./

RUN chmod +x runner.sh entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]


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
