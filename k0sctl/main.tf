data "template_file" "k0sctl_config" {
  template = templatefile("${path.module}/k0sctl.yaml.tpl", {
    cluster_name = var.cluster_name
    user         = var.user
    k0s_hosts    = var.k0s_hosts
    port         = var.port
    ssh_key_path = var.ssh_key_path
  })
}

resource "null_resource" "k0sctl_apply" {
  provisioner "local-exec" {
    command = <<EOT
    echo "${data.template_file.k0sctl_config.rendered}" | k0sctl apply --config -
    EOT
  }
  triggers = {
    config_hash = sha1(data.template_file.k0sctl_config.rendered)
  }
}


resource "null_resource" "k0sctl_kubeconfig" {
  provisioner "local-exec" {
    command = <<EOT
    echo "${data.template_file.k0sctl_config.rendered}" | k0sctl kubeconfig --config - > ${var.kubeconfig_path}
    EOT
  }

  triggers = {
    always_run = timestamp()
  }

  depends_on = [ null_resource.k0sctl_apply ]
}
