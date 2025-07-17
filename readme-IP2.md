# IP2 E-commerce Microservice Project

## 🚀 Overview

This project demonstrates containerization of a full-stack e-commerce dashboard using:

- React frontend
- Node.js backend API
- MongoDB database

It supports product submission and persistent storage using a microservice architecture orchestrated via Docker Compose.

---

## 🔧 Technologies Used

- Node.js
- React
- MongoDB
- Docker & Docker Compose

---

## 📦 Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/kevindev1/IP2-Moringa-DevOps-Creating-a-Basic-Micro-service.git
cd IP2-Moringa-DevOps-Creating-a-Basic-Micro-service
```

### 2. Build and Launch Containers

```bash
docker-compose up --build
```

> ⚠️ Ensure Docker and Docker Compose are installed before running.

---

## 🧪 Product Functionality

To test the “Add Product” feature:

1. Visit `http://localhost:3000` in your browser
2. Use the form to add a retail product
3. Product data will be saved via the backend and stored in MongoDB

---

## 🐳 Docker Image Tags

| Service         | Image Tag                                  |
|----------------|---------------------------------------------|
| Frontend (React) | `kevindev1/yolo-client-redo:v1.0.2`        |
| Backend (Node.js) | `kevindev1/yolo-backend-redo:v1.0.2`      |
| Database (MongoDB) | `mongo:latest`                          |

All images are pushed to Docker Hub and versioned for reproducibility.

---

## 📂 Project Structure

```
├── client
│   ├── Dockerfile
│   └── .dockerignore
├── backend
│   ├── Dockerfile
│   └── .dockerignore
├── docker-compose.yaml
├── README.md
├── explanation.md
└── ...
```

---

## 🛠 Notes and Practices

- `.dockerignore` files added to exclude `node_modules`, `.env`, and temporary files
- Multi-stage Dockerfiles reduce image size and improve performance
- Services communicate over a custom bridge network (`app-net`)
- MongoDB volume (`app-mongo-data`) ensures persistent product data

---

## 👤 Author

Kevin  
[GitHub Profile](https://github.com/kevindev1)

