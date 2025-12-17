const mongoose = require('mongoose');

const courseSchema = new mongoose.Schema({
  courseCode: {
    type: String,
    required: true,
    unique: true,
    uppercase: true
  },
  courseName: {
    type: String,
    required: true
  },
  instructor: {
    type: String,
    required: true
  },
  credits: {
    type: Number,
    required: true,
    min: 1,
    max: 6
  },
  capacity: {
    type: Number,
    required: true,
    default: 30
  },
  enrolled: {
    type: Number,
    default: 0
  }
}, {
  timestamps: true
});

module.exports = mongoose.model('Course', courseSchema);
