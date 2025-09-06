variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "Region for Artifact Registry"
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, prod)"
}
