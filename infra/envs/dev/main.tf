terraform {
  required_version = ">= 1.6.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.10.1, < 3.0.0"
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
  host                   = module.gke.endpoint
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
  token                  = data.google_client_config.default.access_token
}

provider "helm" {
  alias = "gke"
  kubernetes {
    host                   = module.gke.endpoint
    cluster_ca_certificate = base64decode(module.gke.ca_certificate)
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

# ----------------- Helm: ArgoCD -----------------
resource "helm_release" "argocd" {
  provider = helm.gke

  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  # version    = "5.51.6"

  values = [
    file("${path.module}/values/argocd-values.yaml")
  ]

  depends_on = [module.gke]
}

# ----------------- K8s: argoCD Server -----------------
data "kubernetes_service" "argocd_server" {
  provider = kubernetes.gke
  metadata {
    name      = "argocd-server"
    namespace = var.argocd_namespace
  }
}

# ----------------- Modules: Artifact Registry -----------------
module "artifact_registry" {
  source      = "../../modules/artifact-registry"
  project_id  = var.project_id
  region      = var.region
  environment = var.environment
}

# ----------------- Modules: CI/CD Service Account -----------------
module "ci_cd_sa" {
  source               = "../../modules/ci_cd_sa"
  project_id           = var.project_id
  service_account_name = "ci-cd-sa"
}
