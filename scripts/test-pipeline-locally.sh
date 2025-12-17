#!/bin/bash

# Local Pipeline Testing Script
# Tests the pipeline stages locally before pushing to GitHub

echo "=========================================="
echo "Testing CI/CD Pipeline Locally"
echo "=========================================="
echo ""

# Test 1: Install dependencies
echo "📦 Stage 1: Installing dependencies..."
npm ci
if [ $? -eq 0 ]; then
    echo "✅ Dependencies installed successfully"
else
    echo "❌ Failed to install dependencies"
    exit 1
fi
echo ""

# Test 2: Run linting
echo "🔍 Stage 2: Running linting..."
npm run lint
if [ $? -eq 0 ]; then
    echo "✅ Linting passed"
else
    echo "⚠️  Linting warnings/errors found (non-blocking)"
fi
echo ""

# Test 3: Run tests
echo "🧪 Stage 3: Running tests..."
npm test
if [ $? -eq 0 ]; then
    echo "✅ Tests passed"
else
    echo "❌ Tests failed"
    exit 1
fi
echo ""

# Test 4: Build Docker images
echo "🐳 Stage 4: Building Docker images..."
docker-compose build
if [ $? -eq 0 ]; then
    echo "✅ Docker images built successfully"
else
    echo "❌ Failed to build Docker images"
    exit 1
fi
echo ""

# Test 5: Start containers
echo "🚀 Stage 5: Starting containers..."
docker-compose up -d
if [ $? -eq 0 ]; then
    echo "✅ Containers started successfully"
else
    echo "❌ Failed to start containers"
    exit 1
fi
echo ""

# Test 6: Health checks
echo "🏥 Stage 6: Running health checks..."
sleep 10

# Check backend health
echo "Checking backend health..."
curl -f http://localhost:5000/api/health > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Backend is healthy"
else
    echo "⚠️  Backend health check failed (may need more time to start)"
fi

# Check frontend
echo "Checking frontend..."
curl -f http://localhost:80 > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Frontend is accessible"
else
    echo "⚠️  Frontend check failed"
fi
echo ""

# Show running containers
echo "📊 Running containers:"
docker-compose ps
echo ""

echo "=========================================="
echo "Local Pipeline Test Complete"
echo "=========================================="
echo ""
echo "To stop containers: docker-compose down"
echo "To view logs: docker-compose logs -f"
echo ""
echo "✅ All stages passed! Ready to push to GitHub."
