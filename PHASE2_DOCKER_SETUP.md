# 🐳 PHASE 2 - CONTAINERIZATION

## ✅ What's Been Created:

### Dockerfiles:
1. **backend/Dockerfile** - Backend API container
2. **frontend/Dockerfile** - Frontend Nginx container
3. **docker-compose.yml** - Orchestrates all services

### Features:
- ✅ Separate containers for Frontend, Backend, Database
- ✅ Common network for inter-container communication
- ✅ Persistent volumes for MongoDB data
- ✅ Health checks for all services
- ✅ Auto-restart policies
- ✅ Optimized with .dockerignore files

---

## 🚀 COMMANDS TO RUN:

### Step 1: Stop Local Services
```bash
# Stop the local backend (Ctrl+C in the terminal where npm start is running)

# Stop local MongoDB
docker stop mongodb
```

### Step 2: Build and Start All Containers
```bash
docker-compose up --build
```

**Or run in detached mode (background):**
```bash
docker-compose up --build -d
```

### Step 3: Verify Containers are Running
```bash
docker-compose ps
```

You should see:
- ✅ course-mongodb (port 27017)
- ✅ course-backend (port 5000)
- ✅ course-frontend (port 80)

### Step 4: Access the Application
Open your browser and go to:
```
http://localhost
```

---

## 📋 Docker Commands Reference:

### Start Services:
```bash
docker-compose up -d
```

### Stop Services:
```bash
docker-compose down
```

### Stop and Remove Volumes (Clean Start):
```bash
docker-compose down -v
```

### View Logs:
```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f backend
docker-compose logs -f frontend
docker-compose logs -f mongodb
```

### Restart Services:
```bash
docker-compose restart
```

### Rebuild Containers:
```bash
docker-compose up --build -d
```

### Check Container Status:
```bash
docker-compose ps
```

### Check Container Health:
```bash
docker ps
```

---

## 🔍 Verify Everything Works:

### 1. Check Backend Health:
```bash
curl http://localhost:5000/api/health
```

### 2. Check Frontend:
```bash
curl http://localhost
```

### 3. Check MongoDB:
```bash
docker exec -it course-mongodb mongosh --eval "db.adminCommand('ping')"
```

---

## 📊 Container Architecture:

```
┌─────────────────────────────────────────────┐
│         Docker Network (Bridge)             │
│                                             │
│  ┌──────────────┐  ┌──────────────┐       │
│  │   Frontend   │  │   Backend    │       │
│  │   (Nginx)    │  │   (Node.js)  │       │
│  │   Port: 80   │  │   Port: 5000 │       │
│  └──────┬───────┘  └──────┬───────┘       │
│         │                  │                │
│         │                  │                │
│         │         ┌────────▼────────┐      │
│         │         │    MongoDB      │      │
│         │         │   Port: 27017   │      │
│         │         │  (Persistent)   │      │
│         │         └─────────────────┘      │
│         │                                   │
└─────────┼───────────────────────────────────┘
          │
    ┌─────▼─────┐
    │  Browser  │
    │  (User)   │
    └───────────┘
```

---

## 📦 Volumes (Data Persistence):

- **mongodb_data** - Database files
- **mongodb_config** - MongoDB configuration

Data persists even if containers are stopped/removed!

---

## 🌐 Network Configuration:

- **Network Name:** course-management-network
- **Type:** Bridge
- **Services:** frontend, backend, mongodb
- **Communication:** Internal DNS resolution

---

## 🔧 Environment Variables:

Backend container uses:
```
PORT=5000
MONGODB_URI=mongodb://mongodb:27017/course_management
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
NODE_ENV=production
```

---

## 🐛 Troubleshooting:

### Problem: Port already in use
```bash
# Check what's using the port
netstat -ano | findstr :80
netstat -ano | findstr :5000

# Stop local services
docker stop mongodb
# Stop npm start (Ctrl+C)
```

### Problem: Containers won't start
```bash
# Check logs
docker-compose logs

# Rebuild from scratch
docker-compose down -v
docker-compose up --build
```

### Problem: Can't connect to backend
```bash
# Check backend logs
docker-compose logs backend

# Verify network
docker network inspect course-management-network
```

---

## 🎯 Testing the Containerized App:

1. **Register a new user:**
   - Go to http://localhost
   - Click "Register here"
   - Create account

2. **Login:**
   - Enter credentials
   - Access main application

3. **Test all features:**
   - Add students
   - Create courses
   - Enroll students

---

## 📈 Container Health Checks:

All containers have health checks:
- **MongoDB:** Ping test every 10s
- **Backend:** API health endpoint every 30s
- **Frontend:** HTTP check every 30s

View health status:
```bash
docker ps
```

---

## 🔄 Update Application:

After code changes:
```bash
# Rebuild and restart
docker-compose up --build -d

# Or rebuild specific service
docker-compose up --build -d backend
```

---

## ✅ PHASE 2 COMPLETE!

Your application is now fully containerized with:
- ✅ Separate Dockerfiles for each service
- ✅ Docker Compose orchestration
- ✅ Common network
- ✅ Persistent database volumes
- ✅ Health checks
- ✅ Auto-restart policies

**Ready for PHASE 3 - CI/CD Pipeline!** 🚀
