

# First stage: Build
FROM node:14-alpine AS build
WORKDIR /usr/src/app

# Copy dependencies files first for efficient caching
COPY package*.json ./
RUN npm install --legacy-peer-deps

# Copy the rest of the application code
COPY . .
# Set environment variables for React build
# Accept API URL as a build arg
ARG REACT_APP_API_URL
ENV REACT_APP_API_URL=$REACT_APP_API_URL

RUN npm run build

# Second stage: Runtime
FROM node:14-alpine AS runtime
WORKDIR /app

# Copy built files from the first stage
COPY --from=build /usr/src/app /app

# Ensure the app binds to all network interfaces inside the container
ENV HOST=0.0.0.0

# Expose port for serving the app
EXPOSE 3000

# Use serve to run the built React frontend
CMD ["npx", "serve", "-s", "build"]