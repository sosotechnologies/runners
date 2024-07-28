[GH-Runnere-Release](https://github.com/actions/runner/releases)

```yaml
.
├── README.md
├── VERSION
├── argo-artifacts
│   ├── application.yaml
│   ├── deployment.yaml
│   ├── kustomization.yaml
│   └── service.yaml
├── docker
│   └── runner
│       ├── Dockerfile
│       └── runner-scripts
│           └── start.sh
└── scripts
    └── bump_version.sh
```

## building with the pipeline

## After building, create an AWS Secret and GH PAT secret

```sh
kubectl create secret docker-registry ecr-registry-secret \
    --docker-server=368085106192.dkr.ecr.us-east-1.amazonaws.com \
    --docker-username=AWS \
    --docker-password=$(aws ecr get-login-password --region us-east-1) \
    --docker-email=youremail@example.com
```

## create a secret of your GH token
```sh
kubectl create secret generic github-token-secret --from-literal=GH_TOKEN=github_pat_11A34YAFQ0U4xr.........
```

## Apply the argo application
```sh
kubectl apply -f argo-artifacts/application.yaml
kubectl get pods -l app=github-actions-runner
```

## OPTIONALLY ###

### building and running with docker locally
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




