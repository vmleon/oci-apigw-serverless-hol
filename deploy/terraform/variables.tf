
variable "tenancy_ocid" {
  type = string
}

variable "region" {
  type = string
}

variable "compartment_ocid" {
  type = string
}

variable "ssh_public_key" {
  type = string
}

variable "config_file_profile" {
  type = string
}

variable "rsa_public_key" {
  type = string
}

variable "create_dynamic_group" {
  type    = bool
  default = true
}

variable "create_policy" {
  type    = bool
  default = true
}
