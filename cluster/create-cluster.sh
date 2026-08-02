#!/bin/bash
set -e
CLUSTER_NAME="webstack-cluster"
if k3d cluster list | grep -q "$CLUSTER_NAME"; then
  echo "Existing cluster found, deleting..."
  k3d cluster delete "$CLUSTER_NAME"
fi
k3d cluster create --config ./cluster/k3d-config.yaml
kubectl get nodes
echo "✅ Webstack cluster ready!"
