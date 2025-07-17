# explanation.md

## 🛠 Microservice Web Application with Node.js, MongoDB, and Docker Compose

This project showcases a containerized e-commerce dashboard application composed of a React frontend, Node.js backend, and MongoDB database. Each service runs in its own container, orchestrated by Docker Compose.

---

## 📦 Choice of Base Images

### Node.js 14 (LTS)
Chosen for compatibility with legacy dependencies and stability in production environments.

### Node.js 14-alpine
Used in the runtime stage to minimize image size, reduce attack surface, and streamline deployment.

---

## 🐳 Dockerfile Directives

| Directive   | Purpose                                               |
|-------------|-------------------------------------------------------|
| `FROM`      | Declares base image for build and runtime stages      |
| `WORKDIR`   | Sets container's working directory                    |
| `COPY`      | Transfers source code and dependencies                |
| `RUN`       | Installs packages and builds app                      |
| `EXPOSE`    | Documents ports used by each service                  |
| `CMD`       | Launches the service inside the container             |

Multi-stage builds are used in both Dockerfiles to separate build logic from runtime logic, reducing final image size and improving maintainability.

---

## 🌐 Docker Compose Networking

A custom bridge network `app-net` allows services to communicate via container names:

- The backend connects to MongoDB using `app-ip-mongo`
- The frontend communicates with the backend via `yolo-backend`

### Ports

| Service   | Port Mapping   |
|-----------|---------------|
| Frontend  | 3000:3000      |
| Backend   | 5000:5000      |
| MongoDB   | 27017:27017    |

IPAM settings were configured to control subnet and IP ranges for predictable container addressing.

---

## 💾 Volume Definition & Persistence

MongoDB uses a named volume `app-mongo-data`:

- Mounted at `/data/db` inside the container
- Ensures product entries persist across rebuilds and restarts
- Supports testability of the “Add Product” feature

---

## 🔁 Git Workflow and Tagging Strategy

- Project forked and cloned for local development
- Semantic tags applied during build time (e.g. `v1.0.0`, `v1.0.2`)
- Tagged images pushed to Docker Hub:  
  `kevindev1/yolo-client-redo:v1.0.2`  
  `kevindev1/yolo-backend-redo:v1.0.2`

Image tagging was managed inline during builds to maintain version clarity and reduce redundant retagging.

---

## 🔍 Debugging Measures

- MongoDB integration tested via container logs
- `.dockerignore` added to optimize image size and exclude sensitive files (e.g. `.env`, `node_modules`)
- Rebuilt images with `--no-cache` to reflect `.dockerignore` improvements
- Dangling images pruned post-build to maintain clarity and conserve local storage

---

## 🔖 Good Practices

- Multi-stage Dockerfiles with production-grade comments
- Explicit container naming for clarity
- Tagged images with semantic versions for reproducibility
- Optimized build context with `.dockerignore` to minimize image bloat

