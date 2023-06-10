# Base image
FROM node:16

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy project files
COPY . .

# Build project
RUN npm run build

# Expose the container port
EXPOSE 3000

# Command to start the application
CMD [ "npm", "run", "serve" ]
