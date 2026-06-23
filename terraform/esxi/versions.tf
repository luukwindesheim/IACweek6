terraform {
  required_version = ">= 1.9.0"

  backend "local" {
    path = "/home/student/tf-state/week6-esxi.tfstate"
  }

  required_providers {
    vsphere = { source = "hashicorp/vsphere", version = ">= 2.7.0" }
    local   = { source = "hashicorp/local", version = ">= 2.4.0" }
  }
}
