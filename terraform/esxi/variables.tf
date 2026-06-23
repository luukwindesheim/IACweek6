variable "vsphere_server" {
  type = string
}

variable "vsphere_user" {
  type = string
}

variable "vsphere_password" {
  type      = string
  sensitive = true
}

variable "datastore" {
  type    = string
  default = "datastore1"
}

variable "network" {
  type    = string
  default = "VM Network"
}

variable "resource_pool" {
  type    = string
  default = "Resources"
}

variable "ova_path" {
  type = string
}

variable "admin_user" {
  type    = string
  default = "student"
}

variable "ssh_pubkey" {
  type = string
}

variable "disk_gb" {
  type    = number
  default = 10
}

variable "ip_output_file" {
  type    = string
  default = "/tmp/week6_esxi_ip.txt"
}
