#!/bin/bash
set -e

kubectl apply -f manifests/namespace.yaml
kubectl apply -f manifests/configmap.yaml
kubectl apply -f manifests/nginx/configmap.yaml
kubectl apply -f manifests/redis/
kubectl apply -f manifests/flask-api/
kubectl apply -f manifests/nginx/

echo "✅ All manifests deployed, waiting for workloads to become ready..."
kubectl wait --for=condition=ready pod -n web-stack --all --timeout=180s

echo ""
kubectl get all -n web-stack

echo ""
echo "🔗 Access URL (NodePort):"
kubectl get svc -n web-stack nginx -o jsonpath='http://{.items[0].spec.ports[0].nodePort}'
echo ""
