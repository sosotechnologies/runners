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