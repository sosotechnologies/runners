name: CI

on: [push, pull_request]

jobs:
  build:
    runs-on: self-hosted

    steps:
    - name: Checkout repository
      uses: actions/checkout@v2

    - name: Run a simple script
      run: echo "Hello from the self-hosted runner!"
