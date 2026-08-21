#!/bin/bash
set -e
CLUSTER_NAME="webstack-cluster"
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
if k3d cluster list 2>/dev/null | grep -q "$CLUSTER_NAME"; then
  echo "Existing cluster found, deleting..."
  k3d cluster delete "$CLUSTER_NAME"
fi
k3d cluster create --config "${SCRIPT_DIR}/k3d-config.yaml"
kubectl get nodes
echo "✅ Webstack cluster ready!"
