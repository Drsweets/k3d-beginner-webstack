#!/bin/bash
set -e
kubectl apply -f manifests/namespace.yaml
kubectl apply -f manifests/configmap.yaml
kubectl apply -f manifests/nginx/configmap.yaml
kubectl apply -f manifests/redis/
kubectl apply -f manifests/flask-api/
kubectl apply -f manifests/nginx/
echo "✅ All manifests deployed"
kubectl get all -n web-stack
