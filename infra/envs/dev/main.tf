terraform {
  required_version = ">= 1.6.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.10"
    }
  }
}

# ----------------- Providers -----------------
provider "google" {
  project = var.project_id
  region  = var.region
}

# The data source for credentials for K8s/Helm
data "google_client_config" "default" {}

provider "kubernetes" {
  alias                  = "gke"
  host                   = google_container_cluster.primary.endpoint
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

provider "helm" {
  alias = "gke"
  kubernetes {
    host                   = google_container_cluster.primary.endpoint
    cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
    token                  = data.google_client_config.default.access_token
  }
}

# ----------------- Module: APIs -----------------
module "apis" {
  source      = "../../modules/apis"
  project_id  = var.project_id
  environment = var.environment
}

# ----------------- Module: GKE -----------------
module "gke" {
  source       = "../../modules/gke"
  project_id   = var.project_id
  region       = var.region
  environment  = var.environment
  cluster_name = var.cluster_name
  node_count   = var.node_count
  machine_type = var.machine_type
}