# yay -S cdrtools

terraform {
required_version = ">= 0.13"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.1"
    }
  }
}

# instance the provider
provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_pool" "ubuntu" {
  name = "ubuntu"
  type = "dir"
  path = "/tmp/terraform-provider-libvirt-pool-ubuntu"
}

resource "libvirt_volume" "ubuntu-qcow2" {
  name   = "ubuntu-qcow2"
  pool   = libvirt_pool.ubuntu.name
  source = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
  #source = "~/Download/jammy-server-cloudimg-amd64.img"
  format = "qcow2"
}

data "template_file" "network_config" {
  template = file("${path.module}/network_config.cfg")
}

resource "libvirt_cloudinit_disk" "commoninit" {
  name           = "commoninit.iso"
  #user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool           = libvirt_pool.ubuntu.name
}

# Create the machine
resource "libvirt_domain" "domain-ubuntu" {
  name   = "ubuntu-terraform"
  memory = "2048"
  vcpu   = 2

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    network_name = "default"
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = libvirt_volume.ubuntu-qcow2.id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello World'"
    ]

    connection {
      type                = "ssh"
      user                = var.ssh_username
      host                = libvirt_domain.domain-ubuntu.network_config.address
      private_key         = file(var.ssh_private_key)
      bastion_host        = "ams-kvm-remote-host"
      bastion_user        = "deploys"
      bastion_private_key = file("~/.ssh/id_ed25519.pub")
      timeout             = "2m"
    }
  }
}

# IPs: use wait_for_lease true or after creation use terraform refresh and terraform show for the ips of domain

# variavel
variable "ssh_username" {
  description = "the ssh user to use"
  default     = "ubuntu"
}
variable "ssh_private_key" {
  description = "chave de entrada fds"
  default = "~/.ssh/id_ed25519.pub"
}


# https://blog.ruanbekker.com/blog/2020/10/08/using-the-libvirt-provisioner-with-terraform-for-kvm/
# https://askubuntu.com/questions/451673/default-username-password-for-ubuntu-cloud-image
# https://stackoverflow.com/questions/64945275/terraform-ec2-permission-denied-publickey