#!/bin/bash
set -e
docker build -t flask-api:local manifests/flask-api/
k3d image import flask-api:local -c webstack-cluster
kubectl apply -f manifests/namespace.yaml
kubectl apply -f manifests/configmap.yaml
kubectl apply -f manifests/nginx/configmap.yaml
kubectl apply -f manifests/redis/
kubectl apply -f manifests/flask-api/
kubectl apply -f manifests/nginx/
echo "✅ All manifests deployed, waiting for workloads to become ready..."
for deploy in $(kubectl get deployments -n web-stack -o jsonpath='{.items[*].metadata.name}'); do
  kubectl rollout status deployment/"$deploy" -n web-stack --timeout=120s
done
echo ""
kubectl get all -n web-stack
echo ""
echo "🔗 Access URL: http://localhost:8080"
echo ""
