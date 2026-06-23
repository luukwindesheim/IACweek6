variable "subscription_id" { type = string }
variable "tenant_id" { type = string }
variable "resource_group_name" { type = string }

variable "ssh_public_key" {
  type = string
}

variable "vm_size" {
  type    = string
  default = "Standard_B2ats_v2"
}

variable "vm_name" {
  type    = string
  default = "hybrid-web-01"
}

variable "ip_output_file" {
  type    = string
  default = "/tmp/week6_azure_ip.txt"
}
