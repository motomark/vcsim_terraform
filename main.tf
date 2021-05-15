terraform { 
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version        = "1.15.0"
    }
  }

  required_version = ">= 0.14.9"
}


provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  # If you have a self-signed cert
  allow_unverified_ssl = var.allow_unverified_ssl 
}

data "vsphere_datacenter" "dc" {
  name = "DC0"
}

data "vsphere_datastore" "datastore" {
  name          = "LocalDS_0"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = "/DC0/host/DC0_H0/Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "DC0_DVPG0"
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = "terraform-test"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 1024
  guest_id = "otherGuest"

  wait_for_guest_ip_timeout = "0"
  wait_for_guest_net_timeout = "0"

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = 20
  }
}
