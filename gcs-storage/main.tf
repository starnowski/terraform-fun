terraform {
  required_version = ">= 1.6.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0.0"
    }
  }
}

module "gcs_create" {
  source = "../gcs-create"

  name                        = var.name
  location                    = var.location
  project                     = var.project
  force_destroy               = var.force_destroy
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_bucket_level_access
  public_access_prevention    = var.public_access_prevention
  rpo                         = var.rpo
  enable_object_retention     = var.enable_object_retention
  labels                      = var.labels
  autoclass                   = var.autoclass
  cors                        = var.cors
  custom_placement_config     = var.custom_placement_config
  encryption                  = var.encryption
  hierarchical_namespace      = var.hierarchical_namespace
  lifecycle_rule              = var.lifecycle_rule
  logging                     = var.logging
  retention_policy            = var.retention_policy
  soft_delete_policy          = var.soft_delete_policy
  versioning                  = var.versioning
  website                     = var.website
}
