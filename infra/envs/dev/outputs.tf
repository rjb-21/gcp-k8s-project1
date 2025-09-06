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

output "argocd_server_ip" {
  value = try(data.kubernetes_service.argocd_server.status[0].load_balancer[0].ingress[0].ip, null)
}

output "ci_cd_sa_key_json" {
  value     = module.ci_cd_sa.ci_cd_sa_key_json
  sensitive = true
}