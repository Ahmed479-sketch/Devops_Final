# 🐳 RUN CONTAINERIZED APPLICATION

## ✅ CURRENT STATUS: ALL CONTAINERS RUNNING!

### Running Containers:
- ✅ **course-mongodb** - MongoDB Database (port 27017)
- ✅ **course-backend** - Node.js API (port 5000)
- ✅ **course-frontend** - Nginx Web Server (port 80)

---

## 🌐 ACCESS YOUR APPLICATION:

**Open in browser:** http://localhost

---

## 📋 COMMANDS TO MANAGE:

### View Container Status:
```bash
docker ps
```

### View Logs (Real-time):
```bash
# All services
docker-compose logs -f

# Specific service
docker logs course-backend -f
docker logs course-frontend -f
docker logs course-mongodb -f
```

### Stop All Containers:
```bash
docker-compose down
```

### Start All Containers:
```bash
docker-compose up -d
```

### Restart All Containers:
```bash
docker-compose restart
```

### Rebuild and Restart:
```bash
docker-compose up --build -d
```

---

## 🔍 VERIFY EVERYTHING WORKS:

### 1. Check Backend Health:
```bash
curl http://localhost:5000/api/health
```
Expected: `{"status":"OK","message":"Server is running"}`

### 2. Check Frontend:
```bash
curl http://localhost
```
Expected: HTML content of login page

### 3. Check MongoDB Connection:
```bash
docker logs course-backend --tail 10
```
Expected: `✅ MongoDB Connected`

### 4. Check All Containers:
```bash
docker ps
```
All 3 containers should show "Up" status

---

## 🎯 TEST THE APPLICATION:

1. **Open:** http://localhost
2. **Register** a new account:
   - Username: `testuser`
   - Email: `test@example.com`
   - Password: `test123`
3. **Login** with your credentials
4. **Add Students:**
   - Name: John Doe
   - Email: john@example.com
   - Student ID: S001
5. **Add Courses:**
   - Course Code: CS101
   - Course Name: Introduction to Programming
   - Instructor: Dr. Smith
   - Credits: 3
   - Capacity: 30
6. **Enroll Students** in courses
7. **Verify** enrollment count updates

---

## 🔧 TROUBLESHOOTING:

### Problem: Can't access http://localhost
```bash
# Check if frontend is running
docker ps | findstr frontend

# Check frontend logs
docker logs course-frontend

# Restart frontend
docker restart course-frontend
```

### Problem: 500 Error on Register/Login
```bash
# Check backend logs
docker logs course-backend --tail 30

# Check MongoDB connection
docker logs course-mongodb --tail 20

# Restart backend
docker restart course-backend
```

### Problem: MongoDB not connected
```bash
# Check MongoDB is running
docker ps | findstr mongodb

# Check MongoDB logs
docker logs course-mongodb

# Restart all services
docker-compose restart
```

---

## 🔄 COMPLETE RESTART:

```bash
# Stop everything
docker-compose down

# Start everything fresh
docker-compose up -d

# Wait 10 seconds for services to start
timeout /t 10

# Check status
docker ps

# Open application
start http://localhost
```

---

## 📊 CONTAINER DETAILS:

### Frontend (Nginx):
- **Container:** course-frontend
- **Image:** devopsfinal-frontend
- **Port:** 80
- **URL:** http://localhost

### Backend (Node.js):
- **Container:** course-backend
- **Image:** devopsfinal-backend
- **Port:** 5000
- **API:** http://localhost:5000/api

### Database (MongoDB):
- **Container:** course-mongodb
- **Image:** mongo:latest
- **Port:** 27017
- **Database:** course_management

---

## 🎉 SUCCESS!

Your Course Management System is now running in Docker containers with:
- ✅ Full authentication system
- ✅ Frontend, Backend, Database separation
- ✅ Persistent data storage
- ✅ Network isolation
- ✅ Health checks
- ✅ Auto-restart policies

**Application URL:** http://localhost

Enjoy your containerized application! 🚀
