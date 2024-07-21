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