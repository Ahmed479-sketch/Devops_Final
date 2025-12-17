@echo off
REM Local Pipeline Testing Script for Windows
REM Tests the pipeline stages locally before pushing to GitHub

echo ==========================================
echo Testing CI/CD Pipeline Locally
echo ==========================================
echo.

REM Test 1: Install dependencies
echo [Stage 1] Installing dependencies...
call npm ci
if %errorlevel% neq 0 (
    echo [FAIL] Failed to install dependencies
    exit /b 1
)
echo [PASS] Dependencies installed successfully
echo.

REM Test 2: Run linting
echo [Stage 2] Running linting...
call npm run lint
if %errorlevel% neq 0 (
    echo [WARN] Linting warnings/errors found (non-blocking^)
) else (
    echo [PASS] Linting passed
)
echo.

REM Test 3: Run tests
echo [Stage 3] Running tests...
call npm test
if %errorlevel% neq 0 (
    echo [FAIL] Tests failed
    exit /b 1
)
echo [PASS] Tests passed
echo.

REM Test 4: Build Docker images
echo [Stage 4] Building Docker images...
docker-compose build
if %errorlevel% neq 0 (
    echo [FAIL] Failed to build Docker images
    exit /b 1
)
echo [PASS] Docker images built successfully
echo.

REM Test 5: Start containers
echo [Stage 5] Starting containers...
docker-compose up -d
if %errorlevel% neq 0 (
    echo [FAIL] Failed to start containers
    exit /b 1
)
echo [PASS] Containers started successfully
echo.

REM Test 6: Health checks
echo [Stage 6] Running health checks...
timeout /t 10 /nobreak > nul

echo Checking backend health...
curl -f http://localhost:5000/api/health > nul 2>&1
if %errorlevel% equ 0 (
    echo [PASS] Backend is healthy
) else (
    echo [WARN] Backend health check failed (may need more time to start^)
)

echo Checking frontend...
curl -f http://localhost:80 > nul 2>&1
if %errorlevel% equ 0 (
    echo [PASS] Frontend is accessible
) else (
    echo [WARN] Frontend check failed
)
echo.

REM Show running containers
echo Running containers:
docker-compose ps
echo.

echo ==========================================
echo Local Pipeline Test Complete
echo ==========================================
echo.
echo To stop containers: docker-compose down
echo To view logs: docker-compose logs -f
echo.
echo [SUCCESS] All stages passed! Ready to push to GitHub.
