terraform {
  required_version = ">= 1.6.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0.0"
    }
  }
}

data "google_storage_bucket" "bucket" {
  name    = var.name
  project = var.project
}
