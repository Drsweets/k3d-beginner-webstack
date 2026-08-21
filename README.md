# Simple Web Stack on K3d

A 3-tier web application running on a local K3d (K3s in Docker) cluster:
**Nginx (frontend/reverse proxy) → Flask API (backend) → Redis (cache)**

## Learning Topics
- Kubernetes Namespaces
- Deployments & Pod lifecycle
- ClusterIP / NodePort Services
- ConfigMap environment injection
- Horizontal Pod Autoscaler (HPA)
- Readiness Probes
- Troubleshooting with K9s terminal UI
- 3-tier architecture: Nginx → Flask API → Redis

## Requirements
- Ubuntu / WSL2 Ubuntu
- Docker Engine running
- Git installed

## Procedures

### Step 1: Install all required tools
```bash
chmod +x install-tools.sh
./install-tools.sh
```

### Step 2: Create dedicated K3d cluster
```bash
chmod +x cluster/create-cluster.sh
./cluster/create-cluster.sh
```

### Step 3: Deploy application stack
```bash
chmod +x deploy.sh
./deploy.sh
```

The app will be available at **http://localhost:8080**

### Step 4: Explore cluster resources
```bash
k9s
```

### Step 5: Test Horizontal Scaling

**Manual scaling:**
```bash
kubectl scale deployment flask-api -n web-stack --replicas=3
```

**HPA (auto-scaling based on CPU):**
```bash
kubectl get hpa -n web-stack
kubectl describe hpa flask-api-hpa -n web-stack
```

### Step 6: Verify the application
```bash
curl http://localhost:8080
# Refresh multiple times to see the visit counter increment
```

### Step 7: Full Cleanup
```bash
chmod +x destroy.sh
./destroy.sh
```

## Architecture
```
                    ┌─────────────┐
  localhost:8080 ──►│  NodePort   │
                    │  30080      │
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │   Nginx     │  (reverse proxy, port 80)
                    └──────┬──────┘
                           │ proxy_pass :5000
                    ┌──────▼──────┐
                    │  Flask API  │  (ClusterIP, port 5000)
                    └──────┬──────┘
                           │
                    ┌──────▼──────┐
                    │    Redis    │  (ClusterIP, port 6379)
                    └─────────────┘
```

## Troubleshooting
```bash
# Check pod status
kubectl get pods -n web-stack

# View pod logs
kubectl logs -n web-stack deployment/flask-api
kubectl logs -n web-stack deployment/nginx

# Describe a failing pod
kubectl describe pod -n web-stack -l app=flask-api

# Exec into a pod
kubectl exec -it -n web-stack deployment/redis -- redis-cli
```
