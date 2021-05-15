variable "vsphere_user" {
  description = "The vsphere user"
  type        = string
  default     = "user"
}

variable "vsphere_password" {
  description = "The vsphere user password"
  type        = string
  default     = "pass"
}

variable "vsphere_server" {
  description = "V Sphere Server name"
  type        = string
  default     = "127.0.0.1:8989"
}

variable "allow_unverified_ssl" {
  description = "SSL"
  type        = bool
  default     = true
}




