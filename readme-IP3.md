

```markdown
# IP3 Infrastructure Automation Project

## 📦 Project Overview

This project is part of the IP3 DevOps curriculum and demonstrates the automation of a containerized microservice application inside a Vagrant-managed Ubuntu VM. It is completed in two stages:

- **Stage One**: Ansible-powered environment setup and container deployment.
- **Stage Two**: Terraform-based orchestration and lifecycle management of the Ansible workflow.

All provisioning takes place locally — no cloud account required — while maintaining infrastructure-as-code principles.

---

## 🔧 Technologies Used

- **Terraform** (via `null_resource` for orchestration)
- **Ansible** (for configuration automation)
- **Docker & Docker Compose**
- **MongoDB**, **Node.js Backend**, **React Frontend**
- **Vagrant + VirtualBox**
- **Ubuntu 22.04 (Jammy)**

---

## 🚀 Deployment Summary

### ✅ Stage One Highlights

- Provisioned Docker and Docker Compose using Ansible.
- Deployed MongoDB container and created volume.
- Set up backend API container linked to MongoDB.
- Launched frontend container and verified service endpoints.
- Resolved system-level conflicts (e.g., KVM vs VirtualBox modules).
- Validated `/api/products` response with seeded items.

### ✅ Stage Two Highlights

- Used Terraform’s `null_resource` to trigger Ansible playbook.
- Implemented timestamp-based re-execution using `triggers`.
- Handled SSH fingerprint and private key path resolution.
- Verified service health, container status, and endpoint reachability.
- Achieved seamless integration between Terraform and Ansible.

---

## 📂 Repository Structure

```
IP2-Moringa-DevOps-Creating-a-Basic-Micro-service/
├── stage_one/
│   ├── playbook.yaml
│   ├── roles/
│   └── docker-compose.yml
├── stage_two/
│   ├── main.tf
│   ├── inventory.ini
│   └── explanation.md
├── .vagrant/
├── Vagrantfile
└── README.md
```

---

## 📚 Documentation

- Full project explanation available in [`explanation-IP3.md`](./stage_two/explanation-IP3.md)
- Covers both stages in detail with annotated Terraform and Ansible walkthroughs

---

## 🌱 Future Enhancements

- Add remote infrastructure provisioning (e.g. AWS EC2) once cloud access is available
- Introduce Terraform modules and remote state
- Parameterize config with `variables.tf`
- Export metadata using `outputs.tf`
- Expand Ansible roles for cloud-native setups

---

## ✍️ Author

**Kevin**.


```

---

# IP3 Infrastructure Automation Project – Combined Explanation

This documentation covers both stages of the IP3 microservice automation project — from Ansible-driven provisioning to Terraform-based orchestration.

---

## ⚙️ Stage One: Base Automation and Container Deployment with Ansible

### 🛠️ Overview

Stage One focused on bootstrapping a fully containerized microservice environment inside a Vagrant-managed Ubuntu VM. Using **Ansible**, I automated the installation and configuration of Docker, Docker Compose, MongoDB, and application services.

### 📦 Environment Setup

- Vagrant box: `ubuntu/jammy64`
- VM boot conflict resolved via KVM module unload:
  ```bash
  sudo modprobe -r kvm_intel
  sudo modprobe -r kvm
  ```

