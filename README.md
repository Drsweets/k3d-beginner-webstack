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



---

## 3. install-tools.sh
```bash
#!/bin/bash
set -e
sudo apt update && sudo apt install -y git curl wget

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin

# Install k3d
wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# Install K9s
curl -sL https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz | tar xz
sudo mv k9s /usr/local/bin
rm LICENSE README.md

echo "✅ Installed: kubectl, k3d, k9s"
kubectl version --client
k3d version
k9s version
