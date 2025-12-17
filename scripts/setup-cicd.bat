@echo off
REM CI/CD Setup Script for Course Management System (Windows)
REM This script helps configure the CI/CD pipeline

echo ==========================================
echo CI/CD Pipeline Setup
echo ==========================================
echo.

REM Check if running in git repository
if not exist .git (
    echo [ERROR] Not a git repository. Please run 'git init' first.
    exit /b 1
)

echo [OK] Git repository detected
echo.

REM Prompt for Docker Hub username
set /p DOCKER_USERNAME="Enter your Docker Hub username: "

if "%DOCKER_USERNAME%"=="" (
    echo [ERROR] Docker Hub username is required
    exit /b 1
)

echo.
echo Updating Kubernetes manifests with Docker Hub username...

REM Update K8s manifests with actual username
if exist k8s (
    powershell -Command "(Get-ChildItem k8s\*.yaml) | ForEach-Object { (Get-Content $_.FullName) -replace 'YOUR_USERNAME', '%DOCKER_USERNAME%' | Set-Content $_.FullName }"
    echo [OK] Kubernetes manifests updated
) else (
    echo [WARN] k8s directory not found
)

echo.
echo ==========================================
echo GitHub Secrets Configuration Required
echo ==========================================
echo.
echo Please add the following secrets to your GitHub repository:
echo (Settings -^> Secrets and variables -^> Actions -^> New repository secret^)
echo.
echo Required secrets:
echo   1. DOCKER_USERNAME = %DOCKER_USERNAME%
echo   2. DOCKER_PASSWORD = ^<your-docker-hub-token^>
echo.
echo For Kubernetes deployment, also add:
echo   3. KUBE_CONFIG = ^<base64-encoded-kubeconfig^>
echo.
echo For Staging deployment, also add:
echo   4. STAGING_HOST = ^<staging-server-ip^>
echo   5. STAGING_USERNAME = ^<ssh-username^>
echo   6. STAGING_SSH_KEY = ^<ssh-private-key^>
echo   7. STAGING_URL = ^<staging-url^>
echo.
echo ==========================================
echo Next Steps
echo ==========================================
echo.
echo 1. Create Docker Hub repositories:
echo    - %DOCKER_USERNAME%/course-backend
echo    - %DOCKER_USERNAME%/course-frontend
echo.
echo 2. Add GitHub secrets as listed above
echo.
echo 3. Push your code to trigger the pipeline:
echo    git add .
echo    git commit -m "feat: add CI/CD pipeline"
echo    git push origin main
echo.
echo 4. Monitor pipeline at:
echo    https://github.com/^<your-username^>/^<repo-name^>/actions
echo.
echo [SUCCESS] Setup script completed!
pause
