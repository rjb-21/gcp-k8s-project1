output "enabled_apis" {
  description = "List of enabled APIs"
  value       = [for s in google_project_service.required : s.service]
}
