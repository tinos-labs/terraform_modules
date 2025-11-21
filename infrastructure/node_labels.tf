resource "kubectl_manifest" "node_labels" {
  for_each = var.node_labels

  yaml_body = <<YAML
apiVersion: v1
kind: Node
metadata:
  name: ${each.key}
  labels:
%{ for k, v in each.value }
    ${k}: ${v}
%{ endfor }
YAML
}
