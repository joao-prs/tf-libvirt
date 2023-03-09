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

resource "libvirt_pool" "almalinux" {
  name = "almalinux"
  type = "dir"
  path = "/tmp/terraform-provider-libvirt-pool"
}


# o recurso abaixo supoe que você ja tem a imagem localmente,
# obtei por esse metodo pos enquanto o terraform sobe e baixa
# a imagem, ele pode gerar erros. Entao baixe a imagem
# primeiramente

# baixe o arquivo:
# wget https://repo.almalinux.org/almalinux/9/isos/x86_64/AlmaLinux-9.1-x86_64-minimal.iso

resource "libvirt_volume" "almalinux-qcow2" {
  name   = "almalinux-qcow2"
  pool   = libvirt_pool.almalinux.name
  source = "~/Download/AlmaLinux-9.1-x86_64-minimal.iso"
  format = "qcow2"
}


data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
}

data "template_file" "network_config" {
  template = file("${path.module}/network_config.cfg")
}


