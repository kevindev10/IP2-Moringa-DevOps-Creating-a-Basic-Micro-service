# Vagrantfile for IP3 – Lightweight VM setup for Ansible provisioning

Vagrant.configure("2") do |config|

  # --------------------------------------
  # Base box configuration (Ubuntu Jammy)
  # --------------------------------------
  config.vm.box = "ubuntu/jammy64"
  config.vm.box_version = "20241002.0.0"

  # --------------------------------------
  # Port forwarding to expose services to host
  # --------------------------------------
  config.vm.network "forwarded_port", guest: 27017, host: 27017   # MongoDB
  config.vm.network "forwarded_port", guest: 5000, host: 5000     # Node.js Backend
  config.vm.network "forwarded_port", guest: 3000, host: 3000     # React Frontend

  # --------------------------------------
  # VirtualBox VM hardware configuration
  # --------------------------------------
  config.vm.provider "virtualbox" do |vb|
    vb.name = "IP3-Automation-Machine"
    vb.memory = 2048     # Allocate 2 GB RAM
    vb.cpus = 2          # Use 2 virtual CPU cores
  end

  # --------------------------------------
  # Minimal shell provisioning (optional)
  # Only ensures apt is present and Ansible can connect
  # You can remove this block if the base box is reliable
  # --------------------------------------
  config.vm.provision "shell", inline: <<-SHELL
    echo "🔧 Preparing VM for Ansible provisioning..."
    echo "✅ VM is ready for Ansible."
  SHELL

  # --------------------------------------
  # Ansible provisioning block
  # This runs playbook.yaml from your host machine after VM boots
  # --------------------------------------
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yaml"   # Main automation entry point
    ansible.verbose  = "v"               # Verbose output during provisioning
  end

end
