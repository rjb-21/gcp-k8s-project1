terraform {
  required_version = ">= 1.6.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# GCS bucket for Terraform state
resource "google_storage_bucket" "tf_state" {
  name          = "${var.project_id}-tf-state"
  location      = var.region
  force_destroy = false

  versioning {
    enabled = true
  }

  uniform_bucket_level_access = true

  labels = {
    environment = "bootstrap"
    managed_by  = "terraform"
  }
}

# Bucket IAM policy to restrict access
resource "google_storage_bucket_iam_member" "admin" {
  bucket = google_storage_bucket.tf_state.name
  role   = "roles/storage.admin"
  member = "user:${var.admin_user_email}"
}
