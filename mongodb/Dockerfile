# MongoDB Custom Image
FROM mongo:latest

# Set maintainer
LABEL maintainer="haji12345"
LABEL description="Custom MongoDB image for Course Management System"

# Set environment variables
ENV MONGO_INITDB_DATABASE=course_management

# Create initialization script directory
RUN mkdir -p /docker-entrypoint-initdb.d

# Copy initialization script
COPY mongodb/init-mongo.js /docker-entrypoint-initdb.d/

# Expose MongoDB port
EXPOSE 27017

# Use the default MongoDB entrypoint
CMD ["mongod"]
