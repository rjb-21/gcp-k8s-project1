output "enabled_apis" {
  description = "List of enabled APIs"
  value       = module.apis.enabled_apis
}

output "gke_cluster_name" {
  description = "Name of the created GKE cluster"
  value       = module.gke.cluster_name
}

output "gke_endpoint" {
  description = "Endpoint of the GKE cluster"
  value       = module.gke.endpoint
}