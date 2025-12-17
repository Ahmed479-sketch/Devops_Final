# Frontend Dockerfile
FROM nginx:alpine

# Copy frontend files to nginx html directory
COPY frontend/*.html /usr/share/nginx/html/
COPY frontend/*.css /usr/share/nginx/html/
COPY frontend/*.js /usr/share/nginx/html/

# Copy custom nginx configuration
COPY frontend/nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
