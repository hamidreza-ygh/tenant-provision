# # Outputs
output "database_uri" {
  value     = data.exoscale_database_uri.my_database.uri
  sensitive = true
}

output "my_cluster_id" {
  value     = data.exoscale_sks_cluster.my-sks-cluster.id
  sensitive = true
}