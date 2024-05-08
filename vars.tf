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