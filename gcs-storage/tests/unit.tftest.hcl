mock_provider "google" {}

run "verify_bucket_creation_with_defaults" {
  command = plan

  variables {
    name = "test-bucket"
  }

  assert {
    condition     = module.gcs_create.bucket.name == "test-bucket"
    error_message = "Bucket name did not match expected value"
  }

  assert {
    condition     = module.gcs_create.bucket.location == "US"
    error_message = "Bucket location did not match default US"
  }

  assert {
    condition     = module.gcs_create.bucket.storage_class == "STANDARD"
    error_message = "Bucket storage class did not match default STANDARD"
  }

  assert {
    condition     = module.gcs_create.bucket.force_destroy == false
    error_message = "Bucket force_destroy did not match default false"
  }
}

run "verify_bucket_creation_with_custom_top_levels" {
  command = plan

  variables {
    name                        = "test-bucket-custom"
    location                    = "EU"
    project                     = "my-custom-project"
    force_destroy               = true
    storage_class               = "NEARLINE"
    uniform_bucket_level_access = true
    public_access_prevention    = "enforced"
    rpo                         = "ASYNC_TURBO"
    enable_object_retention     = true
    labels = {
      env  = "prod"
      team = "devops"
    }
  }

  assert {
    condition     = module.gcs_create.bucket.name == "test-bucket-custom"
    error_message = "Bucket name did not match"
  }

  assert {
    condition     = module.gcs_create.bucket.location == "EU"
    error_message = "Bucket location did not match"
  }

  assert {
    condition     = module.gcs_create.bucket.project == "my-custom-project"
    error_message = "Bucket project did not match"
  }

  assert {
    condition     = module.gcs_create.bucket.force_destroy == true
    error_message = "Bucket force_destroy did not match"
  }

  assert {
    condition     = module.gcs_create.bucket.storage_class == "NEARLINE"
    error_message = "Bucket storage_class did not match"
  }

  assert {
    condition     = module.gcs_create.bucket.rpo == "ASYNC_TURBO"
    error_message = "Bucket rpo did not match"
  }

  assert {
    condition     = module.gcs_create.bucket.enable_object_retention == true
    error_message = "Bucket enable_object_retention did not match"
  }

  assert {
    condition     = module.gcs_create.bucket.labels.env == "prod"
    error_message = "Bucket label 'env' did not match"
  }

  assert {
    condition     = module.gcs_create.bucket.labels.team == "devops"
    error_message = "Bucket label 'team' did not match"
  }

  assert {
    condition     = module.gcs_create.bucket.uniform_bucket_level_access == true
    error_message = "Bucket uniform_bucket_level_access did not match"
  }

  assert {
    condition     = module.gcs_create.bucket.public_access_prevention == "enforced"
    error_message = "Bucket public_access_prevention did not match"
  }
}

run "verify_bucket_creation_with_nested_blocks" {
  command = plan

  variables {
    name = "test-bucket-nested"
    autoclass = {
      enabled                = true
      terminal_storage_class = "ARCHIVE"
    }
    cors = [
      {
        origin          = ["*"]
        method          = ["GET", "HEAD"]
        response_header = ["Content-Type"]
        max_age_seconds = 3600
      }
    ]
    custom_placement_config = {
      data_locations = ["europe-west1", "europe-west3"]
    }
    encryption = {
      default_kms_key_name = "projects/my-project/locations/global/keyRings/my-keyring/cryptoKeys/my-key"
    }
    hierarchical_namespace = {
      enabled = true
    }
    lifecycle_rule = [
      {
        action = {
          type          = "Delete"
          storage_class = null
        }
        condition = {
          age = 30
        }
      }
    ]
    logging = {
      log_bucket        = "my-logging-bucket"
      log_object_prefix = "log-prefix/"
    }
    retention_policy = {
      is_locked        = false
      retention_period = 604800
    }
    soft_delete_policy = {
      retention_duration_seconds = 2592000
    }
    versioning = {
      enabled = true
    }
    website = {
      main_page_suffix = "index.html"
      not_found_page   = "404.html"
    }
  }

  assert {
    condition     = module.gcs_create.bucket.autoclass[0].enabled == true
    error_message = "Autoclass enabled did not match"
  }

  assert {
    condition     = module.gcs_create.bucket.autoclass[0].terminal_storage_class == "ARCHIVE"
    error_message = "Autoclass terminal_storage_class did not match"
  }

  assert {
    condition     = module.gcs_create.bucket.cors[0].max_age_seconds == 3600
    error_message = "CORS max_age_seconds did not match"
  }

  assert {
    condition     = contains(module.gcs_create.bucket.custom_placement_config[0].data_locations, "europe-west1")
    error_message = "Custom placement data_locations did not match"
  }

  assert {
    condition     = module.gcs_create.bucket.encryption[0].default_kms_key_name == "projects/my-project/locations/global/keyRings/my-keyring/cryptoKeys/my-key"
    error_message = "Encryption key name did not match"
  }

  assert {
    condition     = module.gcs_create.bucket.hierarchical_namespace[0].enabled == true
    error_message = "Hierarchical namespace enabled did not match"
  }

  assert {
    condition     = tolist(module.gcs_create.bucket.lifecycle_rule[0].action)[0].type == "Delete"
    error_message = "Lifecycle action type did not match"
  }

  assert {
    condition     = tolist(module.gcs_create.bucket.lifecycle_rule[0].condition)[0].age == 30
    error_message = "Lifecycle condition age did not match"
  }

  assert {
    condition     = module.gcs_create.bucket.logging[0].log_bucket == "my-logging-bucket"
    error_message = "Logging log_bucket did not match"
  }

  assert {
    condition     = module.gcs_create.bucket.retention_policy[0].retention_period == "604800"
    error_message = "Retention policy retention_period did not match"
  }

  assert {
    condition     = module.gcs_create.bucket.soft_delete_policy[0].retention_duration_seconds == 2592000
    error_message = "Soft delete policy retention duration did not match"
  }

  assert {
    condition     = module.gcs_create.bucket.versioning[0].enabled == true
    error_message = "Versioning enabled did not match"
  }

  assert {
    condition     = module.gcs_create.bucket.website[0].main_page_suffix == "index.html"
    error_message = "Website main_page_suffix did not match"
  }
}
