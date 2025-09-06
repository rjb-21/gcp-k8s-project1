# Create the Service Account
resource "google_service_account" "ci_cd" {
  account_id   = var.service_account_name
  display_name = var.service_account_display_name
  project      = var.project_id
}

# Attach IAM roles
resource "google_project_iam_member" "ci_cd_container" {
  project = var.project_id
  role    = "roles/container.admin"
  member  = "serviceAccount:${google_service_account.ci_cd.email}"
}

resource "google_project_iam_member" "ci_cd_artifact" {
  project = var.project_id
  role    = "roles/artifactregistry.admin"
  member  = "serviceAccount:${google_service_account.ci_cd.email}"
}

resource "google_project_iam_member" "ci_cd_sa_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.ci_cd.email}"
}

# Create a JSON key for GitHub Actions
resource "google_service_account_key" "ci_cd_key" {
  service_account_id = google_service_account.ci_cd.name
}
