# FROM node:21-alpine

# WORKDIR /app

# COPY package*.json ./

# RUN npm install

# COPY . .

# RUN npm run build

# EXPOSE 3000

# CMD [ "npm", "start" ]

# Use Node.js 20 LTS version for stability and security
FROM node:21-alpine

# Set environment variables for production
ENV NODE_ENV=production

# Set the working directory in the container
WORKDIR /app

# Copy only package.json and package-lock.json for installing dependencies
COPY package*.json ./

# Install production dependencies
RUN npm ci 

# Install NestJS CLI globally
RUN npm install -g @nestjs/cli

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Expose the application port
EXPOSE 3000

# Use a non-root user for running the app (security best practice)
USER node

# Run the application
CMD ["npm", "run", "start:prod"]
