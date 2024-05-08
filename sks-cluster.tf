locals {
  zone = "at-vie-2"
}

# resource "exoscale_security_group" "my_security_group" {
#   name = "my-sks-cluster-sg"
# }

# resource "exoscale_security_group_rule" "kubelet" {
#   security_group_id = exoscale_security_group.my_security_group.id
#   description       = "Kubelet"
#   type              = "INGRESS"
#   protocol          = "TCP"
#   start_port        = 10250
#   end_port          = 10250
#   # (beetwen worker nodes only)
#   user_security_group_id = exoscale_security_group.my_security_group.id
# }

# resource "exoscale_security_group_rule" "cilium_vxlan" {
#   security_group_id = exoscale_security_group.my_security_group.id
#   description       = "Cilium VXLAN"
#   type              = "INGRESS"
#   protocol          = "UDP"
#   start_port        = 8472
#   end_port          = 8472
#   user_security_group_id = exoscale_security_group.my_security_group.id
# }

# resource "exoscale_security_group_rule" "cilium_health" {
#   security_group_id = exoscale_security_group.my_security_group.id
#   description       = "Cilium Health Check"
#   type              = "INGRESS"
#   protocol          = "ICMP"
#   icmp_code         = 0
#   icmp_type         = 8
#   user_security_group_id = exoscale_security_group.my_security_group.id
# }

# resource "exoscale_security_group_rule" "cilium_health_tcp" {
#   security_group_id = exoscale_security_group.my_security_group.id
#   description       = "Cilium Health Check"
#   type              = "INGRESS"
#   protocol          = "TCP"
#   start_port        = 4240
#   end_port          = 4240
#   user_security_group_id = exoscale_security_group.my_security_group.id
# }

# resource "exoscale_sks_cluster" "my_sks_cluster" {
#    zone = local.zone
#    name = "my-sks-cluster"
#    cni = "cilium"
# }

# # (administration credentials)
# resource "exoscale_sks_kubeconfig" "my_sks_kubeconfig" {
#   zone       = local.zone
#   cluster_id = exoscale_sks_cluster.my_sks_cluster.id
#   user   = "kubernetes-admin"
#   groups = ["system:masters"]
#   ttl_seconds           = 3600
#   early_renewal_seconds = 300
# }
# resource "local_sensitive_file" "my_sks_kubeconfig_file" {
#   filename        = "kubeconfig"
#   content         = exoscale_sks_kubeconfig.my_sks_kubeconfig.kubeconfig
#   file_permission = "0600"
# }
# resource "exoscale_sks_nodepool" "my_sks_nodepool" {
#   zone       = local.zone
#   cluster_id = exoscale_sks_cluster.my_sks_cluster.id
#   name       = "my-sks-nodepool"
#   instance_type = "standard.medium"
#   size          = 2
#   security_group_ids = [
#     exoscale_security_group.my_security_group.id,
#   ]
# }

data "exoscale_sks_cluster" "my-sks-cluster" {
  zone = local.my_zone
  name = "my-sks-cluster"
}

# (administration credentials)
resource "exoscale_sks_kubeconfig" "my_sks_kubeconfig" {
  zone       = local.zone
  cluster_id = data.exoscale_sks_cluster.my-sks-cluster.id
  user   = "kubernetes-admin"
  groups = ["system:masters"]
  ttl_seconds           = 3600
  early_renewal_seconds = 300
}
resource "local_sensitive_file" "my_sks_kubeconfig_file" {
  filename        = "kubeconfig"
  content         = exoscale_sks_kubeconfig.my_sks_kubeconfig.kubeconfig
  file_permission = "0600"
}