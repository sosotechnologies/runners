## 1. Build the docker image
docker build -t cafanwii/github-actions-runner .
docker push cafanwii/github-actions-runner:latest

## 2. create a secret with your github PAT

```sh
kubectl create secret generic github-token-secret --from-literal=GH_TOKEN=github_pat_11A34YAFQ0U4xr.........
```

## 3. Apply the deployment and service files

```sh
kubectl apply -f argo-artifacts/world-pipeline.yaml
kubectl apply -f argo-artifacts/service.yaml
```



## OPTIONAL building and running with docker locally
```sh
docker build -t cafanwii/github-actions-runner .
```

```sh
docker run -d --name github-actions-runner \
  -e GH_OWNER=sosotechnologies \
  -e GH_REPOSITORY=runners \
  -e GH_TOKEN=github_pat_11A34YAF... \   # your GH PAT
  cafanwii/github-actions-runner 
```

```sh
docker logs github-actions-runner
```





## Extras ###################

### Aws Ecr Login
```sh
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <your-account-number>.dkr.ecr.us-east-1.amazonaws.com

docker pull 368085106192.dkr.ecr.us-east-1.amazonaws.com/runners:latest

docker run -itd <your-account-number>.dkr.ecr.us-east-1.amazonaws.com/runners:latest

```

### Force  git push
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


## building with the pipeline

## After building, create an AWS Secret and GH PAT secret

```sh
kubectl create secret docker-registry ecr-secret \
  --docker-server=368085106192.dkr.ecr.us-east-1.amazonaws.com \
  --docker-username=AWS \
  --docker-password=$(aws ecr get-login-password --region us-east-1) \
  #--namespace=argo \
  --docker-email=example@example.com  \
  --dry-run=client -o yaml > awsecr-secret.yaml
```



