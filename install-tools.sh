```bash
#!/bin/bash
set -e
echo "Installing Kubernetes tools..."
# Install kubectl
if ! command -v kubectl &> /dev/null
then
    echo "Installing kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
else
    echo "kubectl already installed"
fi
# Install Helm
if ! command -v helm &> /dev/null
then
    echo "Installing Helm..."
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
else
    echo "helm already installed"
fi
# Install k3d
if ! command -v k3d &> /dev/null
then
    echo "Installing k3d..."
    curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
else
    echo "k3d already installed"
fi
# Install K9s
if ! command -v k9s &> /dev/null
then
    echo "Installing K9s..."
    TMP_DIR=$(mktemp -d)
    curl -sL "https://github.com/derailed/k9s/releases/latest/download/k9s_linux_amd64.tar.gz" -o "${TMP_DIR}/k9s.tar.gz"
    tar -xzf "${TMP_DIR}/k9s.tar.gz" -C "${TMP_DIR}" k9s
    sudo mv "${TMP_DIR}/k9s" /usr/local/bin/
    rm -rf "${TMP_DIR}"
else
    echo "k9s already installed"
fi
echo ""
echo "Installed versions:"
kubectl version --client-only
helm version
k3d version
if command -v k9s &> /dev/null; then
    k9s version
fi
echo ""
echo "Tool installation complete."
```
