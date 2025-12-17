# Course Management System

A full-stack web application for managing students, courses, and enrollments.

## PHASE 1 - LOCAL SETUP (CURRENT)

### Prerequisites
- Node.js (v14 or higher)
- MongoDB (running locally on port 27017)

### Installation Steps

1. **Install Dependencies**
```bash
npm install
```

2. **Start MongoDB**
Make sure MongoDB is running on your system:
```bash
# Windows
mongod

# Or if using MongoDB as a service, it should already be running
```

3. **Start Backend Server**
```bash
npm start
```

The server will start on http://localhost:5000

4. **Open Frontend**
Open `frontend/index.html` in your web browser

### Features
- ✅ Student Registration (Name, Email, Student ID)
- ✅ Course Management (Code, Name, Instructor, Credits, Capacity)
- ✅ Course Enrollment (Students can enroll in courses)
- ✅ Real-time capacity tracking
- ✅ Full CRUD operations for all entities

### API Endpoints

**Students**
- GET /api/students - Get all students
- POST /api/students - Create student
- DELETE /api/students/:id - Delete student

**Courses**
- GET /api/courses - Get all courses
- POST /api/courses - Create course
- DELETE /api/courses/:id - Delete course

**Enrollments**
- GET /api/enrollments - Get all enrollments
- POST /api/enrollments - Create enrollment
- DELETE /api/enrollments/:id - Delete enrollment

### Testing the Application

1. Register a few students
2. Add some courses
3. Enroll students in courses
4. Verify the enrollment count updates
5. Test delete operations

---

## Project Structure
```
course-management-system/
├── backend/
│   ├── models/
│   │   ├── Student.js
│   │   ├── Course.js
│   │   └── Enrollment.js
│   ├── routes/
│   │   ├── students.js
│   │   ├── courses.js
│   │   └── enrollments.js
│   └── server.js
├── frontend/
│   ├── index.html
│   ├── styles.css
│   └── app.js
├── package.json
├── .env
└── README.md
```
