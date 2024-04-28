# Use the official Nginx image as the base image
FROM nginx:latest

# Copy static files into the container
COPY ./template_13 /usr/share/nginx/html

# Expose port 80
EXPOSE 80

