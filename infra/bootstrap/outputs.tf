output "tf_state_bucket" {
  description = "Name of the GCS bucket used for Terraform state"
  value       = google_storage_bucket.tf_state.name
}
