# Customizable parameters
locals {
  my_zone = "at-vie-2"
}

# Read local IP address
# data "http" "myip" {
#   url = "https://ifconfig.me/ip"
# }

resource "exoscale_database" "my_database" {
  zone = local.my_zone
  name = var.db_user

  type = "mysql"
  plan = "hobbyist-2"

  termination_protection = false

  mysql {
    admin_password = var.db_password
    admin_username = var.db_user
    ip_filter = [
      "0.0.0.0/0"
    ]
  }
}


# Export .env file
resource "local_file" "env_file" {
  filename = ".env"
  content = <<EOF
DB_HOST=${split(":", split("@", data.exoscale_database_uri.my_database.uri)[1])[0]}
DB_USER=${var.db_user}
DB_PASS=${var.db_password}
EOF
}

  
# # Export yaml file
# resource "local_file" "app_values_yaml_file" {
#   filename = "app-values.yaml"
#   content = <<EOF
# applications:
#   - name: ${var.app_name}
#     project: default
#     source:
#       chart: "tenant-todo-app"
#       repoURL: "https://hamidreza-ygh.github.io/tenant-software/"
#       targetRevision: 0.2.0
#       helm:
#         values: |
#           image:
#             repository: "ghcr.io/hamidreza-ygh/tenant-software/todo-app"
#             tag: latest

#           envDbHost: ${split(":", split("@", data.exoscale_database_uri.my_database.uri)[1])[0]}
#           envDbPort: 21699
#           envDbUser: ${var.db_user}
#           envDbPass: ${var.db_password}
#           envDbName: "defaultdb"
#     destination:
#       server: https://kubernetes.default.svc
#       namespace: ${var.app_namespace}
#     syncPolicy:
#       automated: {}
#       syncOptions:
#         - CreateNamespace=true
# EOF
# }

data "exoscale_database_uri" "my_database" {
  zone = local.my_zone
  name = exoscale_database.my_database.name
  type = "mysql"
}

# data "exoscale_database_cert" "my_database" {
#   zone = local.my_zone
#   name = exoscale_database.my_database.name
#   type = "mysql"
# }
