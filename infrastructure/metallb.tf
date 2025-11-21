
resource "helm_release" "metallb" {
  name             = "metallb"
  repository       = "https://metallb.github.io/metallb"
  chart            = "metallb"
  namespace        = "metallb-system"
  create_namespace = true
  wait = true
}

resource "kubectl_manifest" "metallb_ipaddresspool" {
    depends_on = [ helm_release.metallb ]
    yaml_body = <<YAML
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: metallb-ip-pool
  namespace: metallb-system
spec:
  addresses:
  - ${var.traefik_ip}/32
YAML
wait = true
}

resource "kubectl_manifest" "metallb_l2advertisement" {
    depends_on = [ kubectl_manifest.metallb_ipaddresspool ]
    yaml_body = <<YAML
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: metallb-l2
  namespace: metallb-system
spec:
  ipAddressPools:
  - metallb-ip-pool
YAML
wait = true
}
