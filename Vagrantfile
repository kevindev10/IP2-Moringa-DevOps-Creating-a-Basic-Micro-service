# Vagrantfile for IP3 – Automating Container Setup with Ansible

Vagrant.configure("2") do |config|

  # Base VM image: Ubuntu Jammy 22.04 LTS
  config.vm.box = "ubuntu/jammy64"
  config.vm.box_version = "20241002.0.0"

  # Port forwarding: allow access from host to services inside VM
  config.vm.network "forwarded_port", guest: 27017, host: 27017    # MongoDB
  config.vm.network "forwarded_port", guest: 5000, host: 5000      # Node.js Backend
  config.vm.network "forwarded_port", guest: 3000, host: 3000      # React Frontend

  # VirtualBox hardware settings
  config.vm.provider "virtualbox" do |vb|
    vb.name = "IP3-Automation-Machine"
    vb.memory = 2048            # Allocate 2GB RAM
    vb.cpus = 2                 # Use 2 virtual CPU cores
  end

  # Provision VM with shell script to install Docker and configure runtime
  config.vm.provision "shell", inline: <<-SHELL
    echo "🔧 Starting VM bootstrap..."
    
    # Update package list
    sudo apt update

    # Install Docker from official repo
    sudo apt install -y docker.io

    # Add vagrant user to docker group (no sudo needed)
    sudo usermod -aG docker vagrant

    # Enable Docker to start on boot
    sudo systemctl enable docker

    # Restart Docker to apply group changes
    sudo systemctl restart docker

    echo "✅ Docker installation complete."
  SHELL

  # Run Ansible playbook from host machine during provisioning
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yaml"  # Your main automation script
    ansible.verbose  = "v"              # Add verbosity (-v)
    # You can increase it to "vv", "vvv", or "vvvv" if deeper logs needed
  end

end
