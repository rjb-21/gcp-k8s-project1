variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "Region for the state bucket"
  type        = string
  default     = "europe-west1"
}

variable "admin_user_email" {
  description = "Admin user email to grant access to the state bucket"
  type        = string
}
