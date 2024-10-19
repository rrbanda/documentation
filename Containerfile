# Use an official Nginx image as the base
FROM registry.access.redhat.com/ubi8/nginx-122

# Copy the static files from the 'public' directory to the Nginx image
ADD .nginx/nginx.conf "${NGINX_CONF_PATH}"
ADD public .

# Run script uses standard ways to run the application
CMD nginx -g "daemon off;"