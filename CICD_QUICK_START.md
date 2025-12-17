# CI/CD Quick Start Guide

## 🚀 Get Started in 5 Minutes

### Step 1: Configure Docker Hub (2 minutes)

1. Go to https://hub.docker.com and sign up/login
2. Create two repositories:
   - Click "Create Repository"
   - Name: `course-backend` (make it public)
   - Name: `course-frontend` (make it public)
3. Generate access token:
   - Account Settings → Security → New Access Token
   - Name it "github-actions"
   - Copy the token (you won't see it again!)

### Step 2: Update Configuration (1 minute)

**Windows:**
```cmd
cd scripts
setup-cicd.bat
```

**Linux/Mac:**
```bash
cd scripts
chmod +x setup-cicd.sh
./setup-cicd.sh
```

Enter your Docker Hub username when prompted.

### Step 3: Configure GitHub Secrets (2 minutes)

1. Go to your GitHub repository
2. Click Settings → Secrets and variables → Actions
3. Click "New repository secret"
4. Add these two secrets:

   **Secret 1:**
   - Name: `DOCKER_USERNAME`
   - Value: Your Docker Hub username

   **Secret 2:**
   - Name: `DOCKER_PASSWORD`
   - Value: The token you copied from Docker Hub

### Step 4: Push and Deploy! (30 seconds)

```bash
git add .
git commit -m "feat: add CI/CD pipeline"
git push origin main
```

### Step 5: Watch It Work!

1. Go to your GitHub repository
2. Click the "Actions" tab
3. Watch your pipeline run! 🎉

---

## 📋 What Happens When You Push?

1. ✅ **Build Stage** - Compiles frontend and backend
2. ✅ **Test Stage** - Runs automated tests
3. ✅ **Docker Stage** - Builds and pushes images to Docker Hub
4. ✅ **Deploy Stage** - Deploys to Kubernetes (if configured)

**Total time: ~10-15 minutes**

---

## 🧪 Test Locally First (Optional)

Before pushing, test the pipeline locally:

**Windows:**
```cmd
cd scripts
test-pipeline-locally.bat
```

**Linux/Mac:**
```bash
cd scripts
chmod +x test-pipeline-locally.sh
./test-pipeline-locally.sh
```

---

## 🎯 Pipeline Triggers

Your pipeline runs automatically when you:
- ✅ Push to `main` branch → Full deployment
- ✅ Push to `develop` branch → Staging deployment
- ✅ Create a Pull Request → Tests only (no deployment)

---

## 🔧 Optional: Kubernetes Deployment

If you want to deploy to Kubernetes:

1. Get your kubeconfig:
   ```bash
   cat ~/.kube/config | base64
   ```

2. Add to GitHub secrets:
   - Name: `KUBE_CONFIG`
   - Value: The base64 output

3. Install nginx-ingress:
   ```bash
   kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.1/deploy/static/provider/cloud/deploy.yaml
   ```

4. Deploy:
   ```bash
   kubectl apply -f k8s/
   ```

---

## 📊 Check Your Deployment

After pipeline completes:

**Docker Hub:**
- Visit: https://hub.docker.com/u/YOUR_USERNAME
- You should see your images with tags

**Kubernetes (if configured):**
```bash
kubectl get pods -n course-management
kubectl get services -n course-management
```

**Local Testing:**
```bash
docker-compose up -d
# Visit http://localhost
```

---

## ❓ Troubleshooting

### Pipeline fails at "Build and Push Docker Images"
- ✅ Check Docker Hub credentials in GitHub secrets
- ✅ Verify repository names match your username
- ✅ Ensure repositories exist and are public

### Tests fail
```bash
# Run locally to see the error
npm test
```

### Docker build fails
```bash
# Test locally
docker-compose build
```

### Need help?
Check the detailed guide: `PHASE3_CICD_SETUP.md`

---

## ✅ Success Checklist

- [ ] Docker Hub account created
- [ ] Two repositories created on Docker Hub
- [ ] Access token generated
- [ ] GitHub secrets configured
- [ ] K8s manifests updated with username
- [ ] Code pushed to GitHub
- [ ] Pipeline running in Actions tab
- [ ] Images visible on Docker Hub

---

## 🎉 You're Done!

Your CI/CD pipeline is now active. Every time you push code:
1. Tests run automatically
2. Docker images build and push
3. Application deploys automatically

**Welcome to automated deployments!** 🚀
