output "kubeconfig_path" {
  value = var.kubeconfig_path

  depends_on = [ null_resource.k0sctl_kubeconfig ]
}