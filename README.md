Simple Web Stack on K3d

## Learning Topics
- Kubernetes Namespaces
- Deployments & Pod lifecycle
- ClusterIP / NodePort Services
- ConfigMap environment injection
- Horizontal Pod scaling
- Troubleshooting with K9s terminal UI
- 3-tier architecture: Nginx (frontend) → Flask API (backend) → Redis (cache)

## Requirements
- Ubuntu / WSL2 Ubuntu
- Docker Engine running
- Git installed

## Step 1: Install all required tools
```bash
chmod +x install-tools.sh
./install-tools.sh

Create dedicated K3d cluster
bash
chmod +x cluster/create-cluster.sh
./cluster/create-cluster.sh

 Deploy application stack
bash
chmod +x deploy.sh
./deploy.sh

Explore cluster resources
bash
k9s


Test Horizontal Scaling
bash
kubectl scale deployment flask-api -n web-stack --replicas=3


Full Cleanup
bash
chmod +x destroy.sh
./destroy.sh
