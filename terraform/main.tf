terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc1"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.proxmox_url
  pm_api_token_id     = var.token_id
  pm_api_token_secret = var.vm_password
  pm_tls_insecure     = true
}

# --- Debian VM Resources ---

resource "null_resource" "debian_template_installer" {
  # This provisioner connects to the Proxmox Host
  provisioner "remote-exec" {
    
    inline = [
      # Downloads and executes the helper script to create the Debian 12 template
      "bash -c \"$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/vm/debian-vm.sh)\""
    ]

    connection {
      type        = "ssh"
      user        = "root"
      host        = "192.168.74.1"
      private_key = file(pathexpand("~/.ssh/id_ed25519"))
    }
  }

  triggers = {
    script_url = "https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/vm/debian-vm.sh"
  }
}

resource "proxmox_vm_qemu" "debian_vm" {
  depends_on = [null_resource.debian_template_installer]

  name        = "debian-vm"
  target_node = "pve2"
  clone       = "debian-12-cloudinit-template" # Clones the template created by the script above
  os_type     = "cloud-init"
  cores       = 2
  sockets     = 1
  memory      = 2048
  scsihw      = "virtio-scsi-pci"
  boot        = "order=scsi0"

  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size    = 32
        }
      }
    }
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  ipconfig0 = "ip=dhcp"

  ciuser     = "root"
  cipassword = var.vm_password
  sshkeys    = <<EOF
${file(pathexpand("~/.ssh/id_ed25519.pub"))}
EOF

  # This provisioner connects to the NEWLY CREATED Debian VM to install Docker and Arrstack
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release git",
      "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",
      "echo \"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo apt-get update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin",
      "sudo systemctl enable --now docker",
      "sudo usermod -aG docker debian",
      "git clone https://github.com/avnit/mediastack.git /home/debian/mediastack",
      "cd /home/debian/mediastack && docker-compose up -d"
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(pathexpand("~/.ssh/id_ed25519"))
      host        = self.default_ipv4_address
    }
  }
}

# --- Home Assistant VM Resource ---

# FIX: Replaced the proxmox_vm_qemu resource for Home Assistant with a null_resource.
# The helper script creates the VM directly, so Terraform only needs to trigger it.
resource "null_resource" "home_assistant_vm_installer" {
  # This provisioner connects to the Proxmox Host
  provisioner "remote-exec" {
    inline = [
      # Downloads and executes the helper script to create the Home Assistant OS VM.
      # This script handles the download, VM creation, and configuration automatically.
      "bash -c \"$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/vm/haos-vm.sh)\""
    ]

    connection {
      type        = "ssh"
      user        = "root"
      host        = "192.168.74.1"
      private_key = file(pathexpand("~/.ssh/id_ed25519"))
    }
  }

  triggers = {
    script_url = "https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/vm/haos-vm.sh"
  }
}
resource "proxmox_vm_qemu" "preprovision-test" {
  preprovision = true
  os_type      = "ubuntu"
}