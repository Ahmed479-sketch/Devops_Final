# 🎯 CI/CD Deployment Checklist

Use this checklist to ensure your CI/CD pipeline is properly configured and ready to deploy.

## 📋 Pre-Deployment Checklist

### 1. Docker Hub Setup
- [ ] Created Docker Hub account at https://hub.docker.com
- [ ] Created repository: `your-username/course-backend`
- [ ] Created repository: `your-username/course-frontend`
- [ ] Generated access token (Account Settings → Security → New Access Token)
- [ ] Saved access token securely (you won't see it again!)

### 2. GitHub Repository Setup
- [ ] Code pushed to GitHub repository
- [ ] Repository has `main` branch
- [ ] Repository has `develop` branch (optional, for staging)

### 3. GitHub Secrets Configuration
Navigate to: Repository → Settings → Secrets and variables → Actions

**Required Secrets:**
- [ ] `DOCKER_USERNAME` = your Docker Hub username
- [ ] `DOCKER_PASSWORD` = your Docker Hub access token

**Optional (for Kubernetes):**
- [ ] `KUBE_CONFIG` = base64 encoded kubeconfig file

**Optional (for Staging Server):**
- [ ] `STAGING_HOST` = staging server IP/hostname
- [ ] `STAGING_USERNAME` = SSH username
- [ ] `STAGING_SSH_KEY` = SSH private key
- [ ] `STAGING_URL` = staging server URL (e.g., http://staging.example.com)

### 4. Configuration Files Updated
- [ ] Ran setup script (`setup-cicd.bat` or `setup-cicd.sh`)
- [ ] Updated K8s manifests with your Docker Hub username
- [ ] Verified `.github/workflows/ci-cd-pipeline.yml` exists
- [ ] Verified `k8s/` directory contains all manifests

### 5. Local Testing (Optional but Recommended)
- [ ] Ran `npm test` successfully
- [ ] Ran `npm run lint` successfully
- [ ] Ran `docker-compose build` successfully
- [ ] Ran `docker-compose up -d` successfully
- [ ] Verified containers are running: `docker-compose ps`
- [ ] Tested backend: http://localhost:5000/api/health
- [ ] Tested frontend: http://localhost:80

## 🚀 Deployment Steps

### Step 1: Initial Deployment
```bash
# Commit all changes
git add .
git commit -m "feat: add CI/CD pipeline"

# Push to main branch
git push origin main
```

### Step 2: Monitor Pipeline
- [ ] Go to GitHub repository
- [ ] Click "Actions" tab
- [ ] See workflow running
- [ ] All jobs show green checkmarks

### Step 3: Verify Docker Images
- [ ] Go to https://hub.docker.com/u/YOUR_USERNAME
- [ ] See `course-backend` image with tags
- [ ] See `course-frontend` image with tags
- [ ] Images have `latest` tag
- [ ] Images have branch name tag
- [ ] Images have commit SHA tag

### Step 4: Verify Deployment (Kubernetes)
```bash
# Check namespace
kubectl get namespace course-management

# Check pods
kubectl get pods -n course-management

# Check services
kubectl get services -n course-management

# Check ingress
kubectl get ingress -n course-management

# View logs
kubectl logs -f deployment/backend -n course-management
kubectl logs -f deployment/frontend -n course-management
```

Expected output:
- [ ] All pods are in "Running" state
- [ ] All pods show "1/1" or "2/2" ready
- [ ] Services have ClusterIP or LoadBalancer IP
- [ ] No error messages in logs

### Step 5: Verify Deployment (Staging Server)
```bash
# SSH to staging server
ssh user@staging-host

# Check containers
docker-compose ps

# View logs
docker-compose logs -f
```

Expected output:
- [ ] All containers are "Up"
- [ ] Backend is healthy
- [ ] Frontend is accessible
- [ ] MongoDB is running

## ✅ Post-Deployment Verification

### Application Health Checks
- [ ] Backend health endpoint responds: `/api/health`
- [ ] Frontend loads successfully
- [ ] Can register a new user
- [ ] Can login with credentials
- [ ] Can view courses
- [ ] Database connection works

### Pipeline Verification
- [ ] Pipeline completes in ~10-15 minutes
- [ ] All jobs pass (green checkmarks)
- [ ] Docker images pushed successfully
- [ ] Deployment completed without errors
- [ ] Health checks pass

### Trigger Verification
Test that pipeline triggers work:

**Test 1: Push to Main**
```bash
echo "# Test" >> README.md
git add README.md
git commit -m "test: pipeline trigger"
git push origin main
```
- [ ] Pipeline runs automatically
- [ ] Deploys to Kubernetes/Production

**Test 2: Push to Develop**
```bash
git checkout develop
echo "# Test" >> README.md
git add README.md
git commit -m "test: staging trigger"
git push origin develop
```
- [ ] Pipeline runs automatically
- [ ] Deploys to Staging

**Test 3: Pull Request**
```bash
git checkout -b test-pr
echo "# Test PR" >> README.md
git add README.md
git commit -m "test: PR trigger"
git push origin test-pr
# Create PR on GitHub
```
- [ ] Pipeline runs automatically
- [ ] Runs tests but doesn't deploy

## 🐛 Troubleshooting Checklist

### If Pipeline Fails at Build Stage
- [ ] Check Node.js version in workflow (should be 18)
- [ ] Verify package.json exists
- [ ] Run `npm ci` locally to test
- [ ] Check for syntax errors in code

### If Pipeline Fails at Test Stage
- [ ] Run `npm test` locally
- [ ] Check test file exists: `backend/tests/api.test.js`
- [ ] Verify environment variables in workflow
- [ ] Check test logs in Actions tab

### If Pipeline Fails at Docker Stage
- [ ] Verify `DOCKER_USERNAME` secret is set
- [ ] Verify `DOCKER_PASSWORD` secret is set
- [ ] Check Docker Hub repositories exist
- [ ] Ensure repositories are public or credentials are correct
- [ ] Verify Dockerfile syntax

### If Pipeline Fails at Deploy Stage (Kubernetes)
- [ ] Verify `KUBE_CONFIG` secret is set correctly
- [ ] Test kubectl locally: `kubectl get nodes`
- [ ] Check K8s manifests syntax: `kubectl apply --dry-run=client -f k8s/`
- [ ] Verify image names in manifests match Docker Hub
- [ ] Check cluster has enough resources

### If Pipeline Fails at Deploy Stage (Staging)
- [ ] Verify all staging secrets are set
- [ ] Test SSH connection: `ssh user@staging-host`
- [ ] Check Docker is installed on staging
- [ ] Verify docker-compose.yml exists on staging
- [ ] Check staging server has enough disk space

## 📊 Success Criteria

Your CI/CD pipeline is successfully deployed when:

- [x] ✅ Pipeline runs automatically on push
- [x] ✅ Pipeline runs automatically on PR
- [x] ✅ All build stages complete successfully
- [x] ✅ Tests pass automatically
- [x] ✅ Docker images build and push
- [x] ✅ Deployment completes without errors
- [x] ✅ Application is accessible
- [x] ✅ Health checks pass
- [x] ✅ Can make changes and redeploy automatically

## 🎉 Completion

Once all items are checked:

1. ✅ Take screenshots of:
   - GitHub Actions successful run
   - Docker Hub images
   - Running application
   - Kubernetes pods (if applicable)

2. ✅ Document any issues encountered and solutions

3. ✅ Test the full workflow end-to-end

4. ✅ Celebrate! 🎊 Your CI/CD pipeline is live!

## 📝 Notes

Use this space to document any custom configurations or issues:

```
Date: _______________
Notes:
_____________________
_____________________
_____________________
_____________________
```

---

**Status:** Ready for deployment  
**Estimated Setup Time:** 15-20 minutes  
**Marks:** 14/14 when complete
