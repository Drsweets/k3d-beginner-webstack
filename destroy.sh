#!/bin/bash
set -e
kubectl delete namespace web-stack --ignore-not-found=true
k3d cluster delete webstack-cluster
echo "✅ Cleanup finished"
