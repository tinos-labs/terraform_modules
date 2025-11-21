output "k0s_hosts" {
  value = [
    for key, droplet in digitalocean_droplet.k0s :
    {
      role = var.k0s_nodes[key].role
      ip   = droplet.ipv4_address
    }
  ]
}

output "traefik_ip" {
  value = digitalocean_reserved_ip.traefik.ip_address
}