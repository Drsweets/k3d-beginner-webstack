#!/bin/bash
set -e

k3d cluster create --config cluster/k3d-config.yaml

kubectl apply -f manifests/ -n web-stack

for deploy in $(kubectl get deployments -n web-stack -o jsonpath='{.items[*].metadata.name}'); do
  kubectl rollout status deployment/"$deploy" -n web-stack --timeout=120s
done

echo "✅ Deployment finished"
