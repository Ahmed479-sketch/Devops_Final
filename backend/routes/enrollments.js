const express = require('express');
const router = express.Router();
const Enrollment = require('../models/Enrollment');
const Student = require('../models/Student');
const Course = require('../models/Course');

// Get all enrollments
router.get('/', async (req, res) => {
  try {
    const enrollments = await Enrollment.find()
      .populate('student')
      .populate('course');
    res.json(enrollments);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

// Create enrollment
router.post('/', async (req, res) => {
  try {
    const { studentId, courseId } = req.body;

    const student = await Student.findById(studentId);
    const course = await Course.findById(courseId);

    if (!student) return res.status(404).json({ message: 'Student not found' });
    if (!course) return res.status(404).json({ message: 'Course not found' });

    if (course.enrolled >= course.capacity) {
      return res.status(400).json({ message: 'Course is full' });
    }

    const existingEnrollment = await Enrollment.findOne({
      student: studentId,
      course: courseId
    });

    if (existingEnrollment) {
      return res.status(400).json({ message: 'Already enrolled in this course' });
    }

    const enrollment = new Enrollment({
      student: studentId,
      course: courseId
    });

    await enrollment.save();

    course.enrolled += 1;
    await course.save();

    student.enrolledCourses.push(courseId);
    await student.save();

    const populatedEnrollment = await Enrollment.findById(enrollment._id)
      .populate('student')
      .populate('course');

    res.status(201).json(populatedEnrollment);
  } catch (error) {
    res.status(400).json({ message: error.message });
  }
});

// Delete enrollment
router.delete('/:id', async (req, res) => {
  try {
    const enrollment = await Enrollment.findById(req.params.id);
    if (!enrollment) return res.status(404).json({ message: 'Enrollment not found' });

    const course = await Course.findById(enrollment.course);
    const student = await Student.findById(enrollment.student);

    if (course) {
      course.enrolled -= 1;
      await course.save();
    }

    if (student) {
      student.enrolledCourses = student.enrolledCourses.filter(
        c => c.toString() !== enrollment.course.toString()
      );
      await student.save();
    }

    await Enrollment.findByIdAndDelete(req.params.id);
    res.json({ message: 'Enrollment deleted successfully' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = router;
