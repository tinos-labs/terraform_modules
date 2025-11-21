resource "digitalocean_project" "k0s_project" {
  name = "k0s-${var.cluster_name}"
}

resource "digitalocean_droplet" "k0s" {
  for_each =  var.k0s_nodes
  image  = var.image
  name   = "${var.cluster_name}-${each.key}-${join("", [for r in split("+", each.value.role) : substr(r, 0, 1)])}"
  region = var.region
  size   = each.value.size
  tags   = ["k0s", var.cluster_name, replace(each.value.role,"+","-")]
  user_data = var.user_data
}

resource "digitalocean_project_resources" "k0s_project_resources" {
  project = digitalocean_project.k0s_project.id
  resources = [ 
    for key, droplet in digitalocean_droplet.k0s:
    droplet.urn
  ]
}
 
resource "digitalocean_reserved_ip" "traefik" { 
  depends_on = [ digitalocean_project_resources.k0s_project_resources ]
  region = var.region
  droplet_id = digitalocean_droplet.k0s[tolist([for k, v in var.k0s_nodes : k if v.role == "worker"])[0]].id
}
