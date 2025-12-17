const API_URL = 'http://135.171.29.113:5000/api';

// Check authentication
function checkAuth() {
    const token = localStorage.getItem('token');
    if (!token) {
        window.location.href = 'login.html';
        return false;
    }
    
    const user = JSON.parse(localStorage.getItem('user'));
    document.getElementById('username-display').textContent = `Welcome, ${user.username}!`;
    return true;
}

// Logout
document.getElementById('logout-btn').addEventListener('click', () => {
    localStorage.removeItem('token');
    localStorage.removeItem('user');
    window.location.href = 'login.html';
});

// Get auth headers
function getAuthHeaders() {
    const token = localStorage.getItem('token');
    return {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
    };
}

// Check auth on page load
if (!checkAuth()) {
    throw new Error('Not authenticated');
}

// Tab switching
function showTab(tabName) {
    document.querySelectorAll('.tab-content').forEach(tab => {
        tab.classList.remove('active');
    });
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.classList.remove('active');
    });
    
    document.getElementById(`${tabName}-tab`).classList.add('active');
    event.target.classList.add('active');
    
    if (tabName === 'enrollments') {
        loadStudentsForDropdown();
        loadCoursesForDropdown();
    }
}

// Show messages
function showMessage(message, type = 'success') {
    const messageDiv = document.createElement('div');
    messageDiv.className = type;
    messageDiv.textContent = message;
    
    const container = document.querySelector('.tab-content.active .section');
    container.insertBefore(messageDiv, container.firstChild);
    
    setTimeout(() => messageDiv.remove(), 3000);
}

// Students
document.getElementById('student-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const studentData = {
        name: document.getElementById('student-name').value,
        email: document.getElementById('student-email').value,
        studentId: document.getElementById('student-id').value
    };
    
    try {
        const response = await fetch(`${API_URL}/students`, {
            method: 'POST',
            headers: getAuthHeaders(),
            body: JSON.stringify(studentData)
        });
        
        if (response.ok) {
            showMessage('Student registered successfully!');
            e.target.reset();
            loadStudents();
        } else {
            const error = await response.json();
            showMessage(error.message, 'error');
        }
    } catch (error) {
        showMessage('Error registering student', 'error');
    }
});

async function loadStudents() {
    try {
        const response = await fetch(`${API_URL}/students`, {
            headers: getAuthHeaders()
        });
        const students = await response.json();
        
        const listDiv = document.getElementById('students-list');
        listDiv.innerHTML = students.map(student => `
            <div class="card">
                <h3>${student.name}</h3>
                <p><strong>ID:</strong> ${student.studentId}</p>
                <p><strong>Email:</strong> ${student.email}</p>
                <p><strong>Enrolled Courses:</strong> ${student.enrolledCourses.length}</p>
                <button class="delete-btn" onclick="deleteStudent('${student._id}')">Delete</button>
            </div>
        `).join('');
    } catch (error) {
        console.error('Error loading students:', error);
    }
}

async function deleteStudent(id) {
    if (!confirm('Are you sure you want to delete this student?')) return;
    
    try {
        await fetch(`${API_URL}/students/${id}`, { 
            method: 'DELETE',
            headers: getAuthHeaders()
        });
        showMessage('Student deleted successfully!');
        loadStudents();
    } catch (error) {
        showMessage('Error deleting student', 'error');
    }
}

// Courses
document.getElementById('course-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const courseData = {
        courseCode: document.getElementById('course-code').value,
        courseName: document.getElementById('course-name').value,
        instructor: document.getElementById('course-instructor').value,
        credits: parseInt(document.getElementById('course-credits').value),
        capacity: parseInt(document.getElementById('course-capacity').value)
    };
    
    try {
        const response = await fetch(`${API_URL}/courses`, {
            method: 'POST',
            headers: getAuthHeaders(),
            body: JSON.stringify(courseData)
        });
        
        if (response.ok) {
            showMessage('Course added successfully!');
            e.target.reset();
            loadCourses();
        } else {
            const error = await response.json();
            showMessage(error.message, 'error');
        }
    } catch (error) {
        showMessage('Error adding course', 'error');
    }
});

async function loadCourses() {
    try {
        const response = await fetch(`${API_URL}/courses`, {
            headers: getAuthHeaders()
        });
        const courses = await response.json();
        
        const listDiv = document.getElementById('courses-list');
        listDiv.innerHTML = courses.map(course => `
            <div class="card">
                <h3>${course.courseCode}</h3>
                <p><strong>Name:</strong> ${course.courseName}</p>
                <p><strong>Instructor:</strong> ${course.instructor}</p>
                <p><strong>Credits:</strong> ${course.credits}</p>
                <p><strong>Capacity:</strong> ${course.enrolled}/${course.capacity}</p>
                <span class="badge">${course.enrolled >= course.capacity ? 'Full' : 'Available'}</span>
                <button class="delete-btn" onclick="deleteCourse('${course._id}')">Delete</button>
            </div>
        `).join('');
    } catch (error) {
        console.error('Error loading courses:', error);
    }
}

async function deleteCourse(id) {
    if (!confirm('Are you sure you want to delete this course?')) return;
    
    try {
        await fetch(`${API_URL}/courses/${id}`, { 
            method: 'DELETE',
            headers: getAuthHeaders()
        });
        showMessage('Course deleted successfully!');
        loadCourses();
    } catch (error) {
        showMessage('Error deleting course', 'error');
    }
}

// Enrollments
async function loadStudentsForDropdown() {
    try {
        const response = await fetch(`${API_URL}/students`, {
            headers: getAuthHeaders()
        });
        const students = await response.json();
        
        const select = document.getElementById('enrollment-student');
        select.innerHTML = '<option value="">Select Student</option>' +
            students.map(s => `<option value="${s._id}">${s.name} (${s.studentId})</option>`).join('');
    } catch (error) {
        console.error('Error loading students:', error);
    }
}

async function loadCoursesForDropdown() {
    try {
        const response = await fetch(`${API_URL}/courses`, {
            headers: getAuthHeaders()
        });
        const courses = await response.json();
        
        const select = document.getElementById('enrollment-course');
        select.innerHTML = '<option value="">Select Course</option>' +
            courses.map(c => `<option value="${c._id}">${c.courseCode} - ${c.courseName}</option>`).join('');
    } catch (error) {
        console.error('Error loading courses:', error);
    }
}

document.getElementById('enrollment-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    
    const enrollmentData = {
        studentId: document.getElementById('enrollment-student').value,
        courseId: document.getElementById('enrollment-course').value
    };
    
    try {
        const response = await fetch(`${API_URL}/enrollments`, {
            method: 'POST',
            headers: getAuthHeaders(),
            body: JSON.stringify(enrollmentData)
        });
        
        if (response.ok) {
            showMessage('Enrollment successful!');
            e.target.reset();
            loadEnrollments();
            loadStudents();
            loadCourses();
        } else {
            const error = await response.json();
            showMessage(error.message, 'error');
        }
    } catch (error) {
        showMessage('Error creating enrollment', 'error');
    }
});

async function loadEnrollments() {
    try {
        const response = await fetch(`${API_URL}/enrollments`, {
            headers: getAuthHeaders()
        });
        const enrollments = await response.json();
        
        const listDiv = document.getElementById('enrollments-list');
        listDiv.innerHTML = enrollments.map(enrollment => `
            <div class="card">
                <h3>${enrollment.student.name}</h3>
                <p><strong>Course:</strong> ${enrollment.course.courseCode}</p>
                <p><strong>Course Name:</strong> ${enrollment.course.courseName}</p>
                <p><strong>Status:</strong> ${enrollment.status}</p>
                <p><strong>Date:</strong> ${new Date(enrollment.enrollmentDate).toLocaleDateString()}</p>
                <button class="delete-btn" onclick="deleteEnrollment('${enrollment._id}')">Drop Course</button>
            </div>
        `).join('');
    } catch (error) {
        console.error('Error loading enrollments:', error);
    }
}

async function deleteEnrollment(id) {
    if (!confirm('Are you sure you want to drop this enrollment?')) return;
    
    try {
        await fetch(`${API_URL}/enrollments/${id}`, { 
            method: 'DELETE',
            headers: getAuthHeaders()
        });
        showMessage('Enrollment dropped successfully!');
        loadEnrollments();
        loadStudents();
        loadCourses();
    } catch (error) {
        showMessage('Error dropping enrollment', 'error');
    }
}

// Initial load
loadStudents();
loadCourses();
loadEnrollments();
