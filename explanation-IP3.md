---

```markdown
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
- Port forwarding enabled for:
  - MongoDB → `27017`
  - Backend API → `5000`
  - Frontend → `3000`
  - SSH → `2222`

### 🔧 Ansible Role Breakdown

#### `system_config`
- Refreshed APT cache
- Installed utility packages
- Installed Docker Engine and Compose
- Added `vagrant` to Docker group
- Restarted and enabled Docker service

#### `docker_setup`
- Created deployment structure
- Deployed MongoDB using Docker Compose

#### `mongo_setup`
- Created volume directory
- Replaced Compose config with Mongo-enabled version
- Verified container status (`app-mongo-1: Up`)

#### `backend_setup`
- Created `.env` file
- Injected backend + Mongo Compose config
- Deployed backend container
- Validated `/api/products` response with seeded JSON

#### `frontend_setup`
- Structured directory and env file
- Injected frontend Compose config
- Deployed frontend container
- Verified frontend response (placeholder content)

### 🧪 Validation

- `/api/products` returned:
  - `"Shirt"`, `"Jacket"`, `"Cuff Links"`
- No unreachable or failed tasks
- Docker services all reachable and stable

---

## 🧱 Stage Two: Terraform-Orchestrated Automation Setup

### 🛠️ Overview

Stage Two introduced **Terraform** as a higher-level orchestration layer. Rather than managing infrastructure directly, Terraform used a `null_resource` to execute the existing Ansible playbook.

### 🔧 `main.tf` Breakdown

#### Provider Configuration

```hcl
terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}
```

#### Local Execution Resource

```hcl
resource "null_resource" "run_ansible_playbook" {
  provisioner "local-exec" {
    command = "ansible-playbook ../playbook.yaml -i ../inventory.ini"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}
```

- `local-exec` invokes Ansible from the host machine
- `triggers` forces re-execution using a dynamic timestamp

### 🧭 SSH & Key Handling

- SSH errors resolved via:
  ```bash
  ssh-keygen -f ~/.ssh/known_hosts -R '[127.0.0.1]:2222'
  ```
- Updated inventory to use correct relative key path:
  ```ini
  ansible_private_key_file=../.vagrant/machines/default/virtualbox/private_key
  ```

### ✅ Terraform Results

- Playbook triggered and executed fully
- Ansible tasks ran idempotently under Terraform control
- Mongo, backend, and frontend containers confirmed running
- Validated `/api/products` response with seeded items
- Frontend deployed and reachable (with pending variable fix)

---

## 🔮 Future Enhancements

- Replace `null_resource` with real infrastructure modules (e.g. AWS EC2)
- Parameterize configs using `variables.tf`
- Use `outputs.tf` to expose container IPs, ports, or service status
- Setup Terraform remote state backend (e.g. S3)
- Cloud-ready provisioning once free tier access is available

---

## ✅ Conclusion

This two-stage setup demonstrates modular, repeatable infrastructure automation using industry-grade tools. Stage One laid the foundation with Ansible; Stage Two scaled orchestration using Terraform. Combined, they showcase a full-stack DevOps workflow ready to evolve into cloud-native deployments.

```

---

