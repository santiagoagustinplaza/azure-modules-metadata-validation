variable "provided_name" {
  description = "The name of the resource to construct the full name"
  type        = string
}

variable "location" {
  description = "The Azure location of the resource"
  type        = string
}

variable "environment" {
  description = "The environment of the resource (must be 'production' or 'development')"
  type        = string

  # Validation block to restrict allowed values
  validation {
    condition     = var.environment == "production" || var.environment == "development"
    error_message = "The environment variable must be either 'production' or 'development'."
  }
}

variable "project_id" {
  description = "The project ID (4 numeric characters)"
  type        = string
}