// MongoDB Initialization Script for Course Management System

db = db.getSiblingDB('course_management');

// Create collections
db.createCollection('courses');
db.createCollection('users');
db.createCollection('enrollments');

// Create indexes for better performance
db.courses.createIndex({ "title": 1 });
db.courses.createIndex({ "instructor": 1 });
db.users.createIndex({ "email": 1 }, { unique: true });
db.enrollments.createIndex({ "userId": 1, "courseId": 1 });

// Insert sample data
db.courses.insertMany([
    {
        title: "Introduction to DevOps",
        description: "Learn the fundamentals of DevOps practices",
        instructor: "John Doe",
        duration: "8 weeks",
        level: "Beginner",
        createdAt: new Date()
    },
    {
        title: "Docker and Kubernetes",
        description: "Master containerization and orchestration",
        instructor: "Jane Smith",
        duration: "10 weeks",
        level: "Intermediate",
        createdAt: new Date()
    }
]);

print('MongoDB initialization completed successfully!');
