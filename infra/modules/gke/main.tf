# Create the GKE cluster
resource "google_container_cluster" "primary" {
  name     = "${var.cluster_name}-${var.environment}"
  location = var.region
  project  = var.project_id

  # Enable Workload Identity for better security
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  # Use VPC-native networking
  networking_mode = "VPC_NATIVE"

  # Default node pool will be removed (we define custom below)
  remove_default_node_pool = true
  initial_node_count       = 1

  release_channel {
    channel = "REGULAR"
  }

  resource_labels = {
    environment = var.environment
    managed_by  = "terraform"
  }
}

# Create a node pool
resource "google_container_node_pool" "primary_nodes" {
  name       = "np-${var.environment}"
  cluster    = google_container_cluster.primary.name
  location   = var.region
  project    = var.project_id

  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    disk_size_gb  = 50
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    labels = {
      environment = var.environment
    }

    tags = [
      "${var.environment}-gke-nodes"
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  management {
    auto_upgrade = true
    auto_repair  = true
  }
}
