variable "cluster_name" {
  description = "Cluster Name"
  type        = string
}

variable "k0s_nodes" {
  description = "Map of  K0s nodes with their roles and name suffixes"
  type = map(object({
    role = string
    size = string
  }))

  default = {}

  validation {
    condition = alltrue([
      for node in values(var.k0s_nodes) :
      contains(["controller", "worker", "controller+worker"], node.role)
    ])
    error_message = "Invalid role specified. Allowed roles are 'controller', 'worker' and 'controller+worker'."
  }
}

variable "image" {
  description = "DigitalOcean droplet image"
  type        = string
  default     = "ubuntu-24-04-x64"
}

variable "region" {
  description = "DigitalOcean region for droplet deployment"
  type        = string
  default     = "blr1"
}

variable "user_data" {
  description = "User data script for droplet initialization"
  type        = string
  default     = ""
}
