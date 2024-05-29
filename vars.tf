variable "exo_secret_key" {
  description = "The secret key for the Exoscale provider"
  type = string
  sensitive = true
}

variable "exo_api_key" {
  description = "The API key for the Exoscale provider"
  type = string
  sensitive = true 
}

variable "db_password" {
  description = "The password for the database"
  type = string
  sensitive = true
}

variable "db_user" {
  description = "The user for the database"
  type = string
}

variable "app_name" {
  description = "The name of tenant application"
  type = string
}

variable "app_namespace" {
  description = "The namespace of tenant application" 
  type = string
}

variable "cloudflare_email" {
  description = "The email address for the Cloudflare provider"
  type = string
  default = "hamidreza.ygh@gmail.com"
}

variable "cloudflare_api_key" {
  description = "The API key for the Cloudflare provider"
  type = string
  default = "8e1ee7c9362b612a25519a10cf893877594e5"
  sensitive = true 
}

variable "cloudflare_domain_zone_id" {
  description = "The Zone ID for the Cloudflare provider"
  type = string
  default = "bc0206a8813f315d41f3f2774fc0fad4"
  
}