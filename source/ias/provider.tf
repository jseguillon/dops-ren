provider "openstack" {
  user_name = "${var.os_user_name}"
  tenant_name = "${var.os_tenant_name}"
  password  = "${var.os_password}"
  auth_url  = "${var.os_auth_url}"
}

variable "os_user_name" {
  default="A65KD8CxARDq"
}

variable "os_tenant_name" {
  default="2276262789431526"
}

variable "os_password" {
}

variable "os_auth_url" {
  default="https://auth.cloud.ovh.net/v2.0/"
}


