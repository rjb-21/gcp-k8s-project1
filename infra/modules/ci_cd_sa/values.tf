variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "service_account_name" {
  description = "Service Account name"
  type        = string
}

variable "service_account_display_name" {
  description = "Display name for the Service Account"
  type        = string
  default     = "CI/CD Service Account"
}
