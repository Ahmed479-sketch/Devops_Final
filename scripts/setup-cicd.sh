#!/bin/bash

# CI/CD Setup Script for Course Management System
# This script helps configure the CI/CD pipeline

echo "=========================================="
echo "CI/CD Pipeline Setup"
echo "=========================================="
echo ""

# Check if running in git repository
if [ ! -d .git ]; then
    echo "❌ Error: Not a git repository. Please run 'git init' first."
    exit 1
fi

echo "✅ Git repository detected"
echo ""

# Prompt for Docker Hub username
read -p "Enter your Docker Hub username: " DOCKER_USERNAME

if [ -z "$DOCKER_USERNAME" ]; then
    echo "❌ Docker Hub username is required"
    exit 1
fi

echo ""
echo "Updating Kubernetes manifests with Docker Hub username..."

# Update K8s manifests with actual username
if [ -d k8s ]; then
    sed -i.bak "s/YOUR_USERNAME/$DOCKER_USERNAME/g" k8s/*.yaml
    rm -f k8s/*.yaml.bak
    echo "✅ Kubernetes manifests updated"
else
    echo "⚠️  k8s directory not found"
fi

echo ""
echo "=========================================="
echo "GitHub Secrets Configuration Required"
echo "=========================================="
echo ""
echo "Please add the following secrets to your GitHub repository:"
echo "(Settings → Secrets and variables → Actions → New repository secret)"
echo ""
echo "Required secrets:"
echo "  1. DOCKER_USERNAME = $DOCKER_USERNAME"
echo "  2. DOCKER_PASSWORD = <your-docker-hub-token>"
echo ""
echo "For Kubernetes deployment, also add:"
echo "  3. KUBE_CONFIG = <base64-encoded-kubeconfig>"
echo ""
echo "For Staging deployment, also add:"
echo "  4. STAGING_HOST = <staging-server-ip>"
echo "  5. STAGING_USERNAME = <ssh-username>"
echo "  6. STAGING_SSH_KEY = <ssh-private-key>"
echo "  7. STAGING_URL = <staging-url>"
echo ""
echo "=========================================="
echo "Next Steps"
echo "=========================================="
echo ""
echo "1. Create Docker Hub repositories:"
echo "   - $DOCKER_USERNAME/course-backend"
echo "   - $DOCKER_USERNAME/course-frontend"
echo ""
echo "2. Add GitHub secrets as listed above"
echo ""
echo "3. Push your code to trigger the pipeline:"
echo "   git add ."
echo "   git commit -m 'feat: add CI/CD pipeline'"
echo "   git push origin main"
echo ""
echo "4. Monitor pipeline at:"
echo "   https://github.com/<your-username>/<repo-name>/actions"
echo ""
echo "✅ Setup script completed!"
