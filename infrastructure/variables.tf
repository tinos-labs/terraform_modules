variable "traefik_ip" {
  description = "Reserved ip for traefik"
  type = string
}

variable "node_labels" {
  description = "Labels for each node"
  type = map(map(string))
  default = {}
}