# Enable required APIs for GKE, Artifact Registry, DNS, etc.
resource "google_project_service" "required" {
  for_each = toset([
    "compute.googleapis.com",         
    "container.googleapis.com",       
    "artifactregistry.googleapis.com",
    "dns.googleapis.com",             
    "sqladmin.googleapis.com",        
    "iam.googleapis.com",             
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",    
    "logging.googleapis.com",         
    "monitoring.googleapis.com"       
  ])

  project = var.project_id
  service = each.value

  disable_dependent_services = true
  disable_on_destroy         = true
}
