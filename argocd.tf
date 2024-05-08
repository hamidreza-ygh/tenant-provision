# locals {
#   repo_url = "https://github.com/hamidreza-ygh/tenant-software"
#   repo_path = "deployment"
#   app_name = "tenant-1-todo-app"
#   app_namespace = "tenant-1"
# }

locals {
  repo_url = "https://hamidreza-ygh.github.io/tenant-software/"
  chart_name = "tenant-todo-app"
  app_name = var.app_name
  app_namespace = var.app_namespace
}


# # resource "helm_release" "argo_cd" {
# #   name             = "argocd"
# #   repository       = "https://argoproj.github.io/argo-helm"
# #   chart            = "argo-cd"
# #   version          = "5.52.0"
# #   timeout          = 1200
# #   create_namespace = true
# #   namespace        = "argocd"
# #   lint             = true
# #   wait             = true

# #   depends_on = [
# #     local_sensitive_file.my_sks_kubeconfig_file
# #   ]
# # }

resource "helm_release" "argo_cd_app" {
  name             = "argocd-apps-${var.db_user}"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argocd-apps"
  version          = "1.4.1"
  timeout          = 1200
  create_namespace = true
  namespace        = "argocd"
  lint             = true
  wait             = true
  values = [templatefile("app-values.yaml", {
    repo_url = local.repo_url
    chart_name = local.chart_name
    app_name = local.app_name
    app_namespace = local.app_namespace
    db_host = split(":", split("@", data.exoscale_database_uri.my_database.uri)[1])[0]
    db_user = var.db_user
    db_pass = var.db_password
  })]

  depends_on = [
    exoscale_database.my_database,
    data.exoscale_database_uri.my_database,
    local_sensitive_file.my_sks_kubeconfig_file
  ]
  
}


# resource "helm_release" "argo_cd_app" {
#   name             = "argocd-apps"
#   repository       = "https://argoproj.github.io/argo-helm"
#   chart            = "argocd-apps"
#   version          = "1.4.1"
#   timeout          = 1200
#   create_namespace = true
#   namespace        = "argocd"
#   lint             = true
#   wait             = true
#   values = [templatefile("app-values copy.yaml", {
#     repo_url = local.repo_url
#     repo_path = local.repo_path
#     app_name = local.app_name
#     app_namespace = local.app_namespace
#   })]

#   depends_on = [
#     local_sensitive_file.my_sks_kubeconfig_file
#   ]
  
# }