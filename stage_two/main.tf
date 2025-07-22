terraform {
  required_providers {
    null = {
      # This tells Terraform to use the null provider — a placeholder that lets us run local scripts.
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

# Fake resource to simulate provisioning — lets us hook into Terraform’s lifecycle.
resource "null_resource" "run_ansible_playbook" {

  # Local exec provisioner: triggers your Ansible playbook from inside Terraform.
  provisioner "local-exec" {
    # This command runs the playbook relative to this file's location.
    command = "ansible-playbook ../playbook.yaml -i ../inventory.ini"
  }

  # Trigger block makes sure the resource gets re-applied every time.
  triggers = {
    always_run = "${timestamp()}"  # Forces re-run on every apply, since timestamp always changes.
  }
}
