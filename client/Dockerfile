# -------------------------------
# Stage 1: Build Stage
# -------------------------------
# Use Node 14 (LTS) base image for compatibility with legacy dependencies
FROM node:14 AS build

# Set working directory inside the container
WORKDIR /usr/src/app

# Copy dependency definitions
COPY package*.json ./

# Install all dependencies (including devDependencies)
RUN npm install

# Copy the rest of the application code
COPY . .

# -------------------------------
# Stage 2: Runtime Stage
# -------------------------------
# Use a lightweight Node 14 Alpine image for the final container
FROM node:14-alpine

# Set working directory for the runtime container
WORKDIR /app

# Copy the built app and dependencies from the build stage
COPY --from=build /usr/src/app .

# Expose the port your backend server listens on
EXPOSE 5000

# Define the default command to run your Node.js backend
CMD ["node", "server.js"]
