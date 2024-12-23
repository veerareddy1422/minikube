# Use the official Apache HTTPD image from Docker Hub
FROM httpd:latest

# Copy your application content (HTML files) to the container
COPY ./public-html/ /usr/local/apache2/htdocs/
