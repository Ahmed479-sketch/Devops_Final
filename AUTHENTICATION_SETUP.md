# 🔐 Authentication Added to Course Management System

## ✅ What's New:

1. **User Registration & Login**
2. **JWT Token Authentication**
3. **Protected API Routes**
4. **Session Management**
5. **Logout Functionality**

---

## 🚀 Commands to Run the Application with Authentication

### Step 1: Make sure MongoDB is running
```bash
docker ps
```
If not running:
```bash
docker start mongodb
```

### Step 2: Start the Backend Server
```bash
npm start
```
**Backend runs on:** http://localhost:5000

### Step 3: Open the Login Page
```bash
start frontend/login.html
```
**Or manually open:** `frontend/login.html` in your browser

---

## 📝 How to Use:

### First Time Users:

1. **Register a New Account:**
   - Open `frontend/login.html`
   - Click "Register here"
   - Fill in:
     - Username (min 3 characters)
     - Email
     - Password (min 6 characters)
     - Confirm Password
   - Click "Register"
   - You'll be automatically logged in and redirected

2. **Login:**
   - Open `frontend/login.html`
   - Enter your username and password
   - Click "Login"
   - You'll be redirected to the main application

3. **Use the Application:**
   - Once logged in, you can:
     - Register students
     - Add courses
     - Create enrollments
   - Your username will be displayed in the top-right corner
   - Click "Logout" to sign out

---

## 🔒 Security Features:

- ✅ Passwords are hashed with bcrypt
- ✅ JWT tokens for authentication
- ✅ Protected API routes (require authentication)
- ✅ Token stored in localStorage
- ✅ Auto-redirect to login if not authenticated
- ✅ 24-hour token expiration

---

## 🧪 Test Accounts:

You can create your own accounts. Here's an example:

**Username:** admin  
**Email:** admin@example.com  
**Password:** admin123

---

## 📡 API Endpoints:

### Public (No Auth Required):
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user

### Protected (Auth Required):
- `GET /api/auth/me` - Get current user
- `GET /api/students` - Get all students
- `POST /api/students` - Create student
- `DELETE /api/students/:id` - Delete student
- `GET /api/courses` - Get all courses
- `POST /api/courses` - Create course
- `DELETE /api/courses/:id` - Delete course
- `GET /api/enrollments` - Get all enrollments
- `POST /api/enrollments` - Create enrollment
- `DELETE /api/enrollments/:id` - Delete enrollment

---

## 🔧 Environment Variables:

The `.env` file now includes:
```
PORT=5000
MONGODB_URI=mongodb://localhost:27017/course_management
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
```

---

## 📂 New Files Added:

```
frontend/
├── login.html          # Login page
├── register.html       # Registration page
├── auth.js            # Authentication logic
└── auth-styles.css    # Auth pages styling

backend/
├── models/
│   └── User.js        # User model with password hashing
├── routes/
│   └── auth.js        # Authentication routes
└── middleware/
    └── auth.js        # JWT verification middleware
```

---

## 🎯 Complete Restart Commands:

```bash
# 1. Make sure MongoDB is running
docker ps

# 2. If MongoDB is not running
docker start mongodb

# 3. Start backend
npm start

# 4. Open login page
start frontend/login.html
```

---

## 🐛 Troubleshooting:

**Problem:** "Authentication required" error  
**Solution:** Make sure you're logged in. Go to `frontend/login.html`

**Problem:** "Invalid token" error  
**Solution:** Your session expired. Logout and login again

**Problem:** Can't register  
**Solution:** Make sure MongoDB is running and backend is started

---

## ✨ Features:

- 🔐 Secure password hashing
- 🎫 JWT token authentication
- 👤 User session management
- 🚪 Login/Logout functionality
- 🛡️ Protected routes
- ⏰ Token expiration (24 hours)
- 📱 Responsive auth pages
- ✅ Form validation

---

Enjoy your secure Course Management System! 🎓
