provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "ha-datacenter"
}

data "vsphere_host" "host" {
  name          = var.vsphere_server
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "ds" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "net" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = "hybrid-db-01"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.ds.id
  host_system_id   = data.vsphere_host.host.id
  datacenter_id    = data.vsphere_datacenter.dc.id

  num_cpus  = 1
  memory    = 2048
  guest_id  = "ubuntu64Guest"
  scsi_type = "lsilogic"

  network_interface {
    network_id   = data.vsphere_network.net.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "disk0"
    thin_provisioned = true
    size             = var.disk_gb
  }

  ovf_deploy {
    local_ovf_path       = var.ova_path
    disk_provisioning    = "thin"
    ip_protocol          = "IPv4"
    ip_allocation_policy = "DHCP"
    ovf_network_map      = { "VM Network" = data.vsphere_network.net.id }
  }

  extra_config = {
    "guestinfo.metadata"          = base64encode(templatefile("${path.module}/metadata.yaml", { hostname = "hybrid-db-01" }))
    "guestinfo.metadata.encoding" = "base64"
    "guestinfo.userdata"          = base64encode(templatefile("${path.module}/userdata.yaml", { admin_user = var.admin_user, ssh_pubkey = file(var.ssh_pubkey) }))
    "guestinfo.userdata.encoding" = "base64"
  }
}

resource "local_file" "esxi_ip" {
  content  = vsphere_virtual_machine.vm.default_ip_address
  filename = var.ip_output_file
}

output "vm_ip" {
  value = vsphere_virtual_machine.vm.default_ip_address
}
