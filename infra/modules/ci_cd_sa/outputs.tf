output "ci_cd_sa_email" {
  value = google_service_account.ci_cd.email
}

output "ci_cd_sa_key_json" {
  value     = google_service_account_key.ci_cd_key.private_key
  sensitive = true
}
