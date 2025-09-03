output "cluster_name" {
  description = "Name of the created GKE cluster"
  value       = google_container_cluster.primary.name
}

output "endpoint" {
  description = "GKE cluster endpoint"
  value       = google_container_cluster.primary.endpoint
}

output "ca_certificate" {
  description = "GKE cluster CA certificate"
  value       = google_container_cluster.primary.master_auth[0].cluster_ca_certificate
}

output "node_pool_name" {
  description = "Name of the created node pool"
  value       = google_container_node_pool.primary_nodes.name
}
