variable "user" {
  description = "Username for SSH connections to K0s nodes"
  type = string
  default = "k0sadmin"
}

variable "cluster_name" {
  description = "Cluster Name"
  type        = string
}

variable "k0s_hosts" {
  description = "List IP addresses of the K0s hosts with their roles"
  type = list(object({
    role = string
    ip   = string
  }))
}

variable "port" {
  description = "Host port"
  type    = number
  default = 5667
}

variable "kubeconfig_path" {
  type = string
}

variable "ssh_key_path" {
  description = "SSH key path"
  type = string
  nullable = true
  default = ""
}