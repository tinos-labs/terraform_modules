apiVersion: k0sctl.k0sproject.io/v1beta1
kind: Cluster
metadata:
  name: ${cluster_name}
  user: ${user}
spec:
  hosts:

%{~ for host in k0s_hosts ~}
    - role: ${host.role}
      privateInterface: eth1
      ssh:
        user: ${user}
        address: ${host.ip}
        port: ${port}
        %{~ if ssh_key_path != null && ssh_key_path != "" ~}
        keyPath: ${ssh_key_path}
        %{~ endif ~}

%{~ endfor ~}
