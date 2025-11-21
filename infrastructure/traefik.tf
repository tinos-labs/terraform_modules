resource "helm_release" "traefik" {
  depends_on = [kubectl_manifest.metallb_l2advertisement]

  name       = "traefik"
  repository = "https://traefik.github.io/charts"
  chart      = "traefik"
  namespace  = "traefik-system"
  create_namespace = true
  wait       = true

  values = [yamlencode({
    service = {
      spec = {
        type           = "LoadBalancer"
        loadBalancerIP = var.traefik_ip
      }
    }
    ingressRoute = {
      dashboard ={
        enabled = true
        matchRule = "PathPrefix(`/dashboard`) || PathPrefix(`/api`)"
        entryPoints = ["web"]
      }
    }
  })]
}

