# Dockerfile for simple-apps
# Author: Rido
# Date: 23 October 2024
# Version: 1.0
# Description: Dockerfile for simple-apps
# Usage: docker build -t simple-apps .
#        docker run -p 3000:3000 simple-apps
# Get from docker hub   
FROM node:18.16.0
# Set working directory
WORKDIR /app
# Add all files from current directory to /app
ADD . /app  
# Install dependencies
RUN npm install
# Start the app
CMD npm start
# Expose port 3000 to the outside world
EXPOSE 3000