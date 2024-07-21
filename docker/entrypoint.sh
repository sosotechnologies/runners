#!/bin/bash

# Set the runner configuration
./config.sh --url ${REPO_URL} --token ${RUNNER_TOKEN} --name $(hostname) --work _work --replace

# Run the runner
./run.sh
