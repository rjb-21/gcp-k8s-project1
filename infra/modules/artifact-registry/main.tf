resource "google_artifact_registry_repository" "docker_repo" {
  provider     = google
  location     = var.region
  repository_id = "${var.environment}-app-repo"
  description  = "Docker repository for ${var.environment} environment"
  format       = "DOCKER"
}
