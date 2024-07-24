.
├── k8s
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── configmap.yaml
│   └── secret.yaml
├── runner
│   ├── runner.sh
│   ├── entrypoint.sh
│   └── Dockerfile
└── README.md

```sh
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <your-account-number>.dkr.ecr.us-east-1.amazonaws.com

docker pull 368085106192.dkr.ecr.us-east-1.amazonaws.com/runners:latest

docker run -itd <your-account-number>.dkr.ecr.us-east-1.amazonaws.com/runners:latest

```

```sh
kubectl create secret docker-registry ecr-secret \
  --docker-server=368085106192.dkr.ecr.us-east-1.amazonaws.com \
  --docker-username=AWS \
  --docker-password=$(aws ecr get-login-password --region us-east-1) \
  #--namespace=argo \
  --docker-email=example@example.com  \
  --dry-run=client -o yaml > awsecr-secret.yaml
```

```sh
echo -n 'your-token-here' | base64

kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/secret.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl get pods -l app=github-runner
```

# Force  git push
```sh 
git checkout --orphan temp_branch
git add -A
git commit -am "Initial commit"
git branch -D main
git branch -m main
git push -f origin main
```

<!-- git checkout --orphan temp_branch: Creates a new branch with no commit history.
git add -A: Adds all files to the staging area.
git commit -am "Initial commit": Commits all files with the message "Initial commit."
git branch -D main: Deletes the old main branch.
git branch -m main: Renames the current branch to main.
git push -f origin main: Force pushes the new main branch to the remote repository, overwriting the existing history. -->

## for imperative cli 

```sh
mkdir actions-runner && cd actions-runner

curl -o actions-runner-linux-x64-2.317.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.317.0/actions-runner-linux-x64-2.317.0.tar.gz

echo "9e883d210df8c6028aff475475a457d380353f9d01877d51cc01a17b2a91161d  actions-runner-linux-x64-2.317.0.tar.gz" | shasum -a 256 -c

tar xzf ./actions-runner-linux-x64-2.317.0.tar.gz
```

cafanwii@macaz:~/actions-runner$ ./config.sh --url https://github.com/sosotechnologies/sosodocker --token A34YAFSC5SOFBKBT7P2RHETGUBIDI

--------------------------------------------------------------------------------
|        ____ _ _   _   _       _          _        _   _                      |
|       / ___(_) |_| | | |_   _| |__      / \   ___| |_(_) ___  _ __  ___      |
|      | |  _| | __| |_| | | | | '_ \    / _ \ / __| __| |/ _ \| '_ \/ __|     |
|      | |_| | | |_|  _  | |_| | |_) |  / ___ \ (__| |_| | (_) | | | \__ \     |
|       \____|_|\__|_| |_|\__,_|_.__/  /_/   \_\___|\__|_|\___/|_| |_|___/     |
|                                                                              |
|                       Self-hosted runner registration                        |
|                                                                              |
--------------------------------------------------------------------------------

# Authentication


√ Connected to GitHub

# Runner Registration

Enter the name of the runner group to add this runner to: [press Enter for Default] 

Enter the name of runner: [press Enter for macaz] 

This runner will have the following labels: 'self-hosted', 'Linux', 'X64' 
Enter any additional labels (ex. label-1,label-2): [press Enter to skip] 

√ Runner successfully added
√ Runner connection is good

# Runner settings

Enter name of work folder: [press Enter for _work] 

√ Settings Saved.


cafanwii@macaz:~/actions-runner$ ./run.sh

√ Connected to GitHub

Current runner version: '2.317.0'
2024-07-24 00:22:04Z: Listening for Jobs

## building and pushing with docker
docker build -t cafanwii/github-actions-runner .
docker run -it cafanwii/github-actions-runner

