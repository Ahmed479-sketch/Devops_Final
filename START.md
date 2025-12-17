# 🚀 QUICK START GUIDE

## Run These Commands in Order:

### 1️⃣ Check MongoDB
```bash
docker ps
```

### 2️⃣ Start MongoDB (if not running)
```bash
docker start mongodb
```
Or if container doesn't exist:
```bash
docker run -d --name mongodb -p 27017:27017 mongo:latest
```

### 3️⃣ Start Backend Server
```bash
npm start
```
✅ Backend will run on: **http://localhost:5000**

### 4️⃣ Open Login Page
```bash
start frontend/login.html
```

---

## 🎯 First Time Setup:

1. **Register Account:**
   - Click "Register here" on login page
   - Create username, email, password
   - Click "Register"

2. **Login:**
   - Enter your credentials
   - Click "Login"

3. **Use the App:**
   - Add students
   - Create courses
   - Enroll students in courses

---

## 🔄 If Something Goes Wrong:

### Restart Everything:
```bash
# Stop backend (Ctrl+C in terminal)

# Restart MongoDB
docker restart mongodb

# Start backend again
npm start

# Open login page
start frontend/login.html
```

---

## ✅ Verify It's Working:

```bash
# Test backend health
curl http://localhost:5000/api/health
```

Should return: `{"status":"OK","message":"Server is running"}`

---

## 📱 Access Points:

- **Login Page:** `frontend/login.html`
- **Register Page:** `frontend/register.html`
- **Main App:** `frontend/index.html` (auto-redirects if not logged in)
- **Backend API:** `http://localhost:5000/api`

---

That's it! Your authenticated Course Management System is ready! 🎉
