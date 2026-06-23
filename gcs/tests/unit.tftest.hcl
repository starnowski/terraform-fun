mock_provider "google" {}

override_data {
  target = data.google_storage_bucket.bucket
  values = {
    name          = "my-bucket-name"
    project       = "my-project-id"
    location      = "US"
    storage_class = "STANDARD"
    self_link     = "https://www.googleapis.com/storage/v1/b/my-bucket-name"
    url           = "gs://my-bucket-name"
  }
}

run "verify_gcs_module_outputs" {
  command = plan

  variables {
    name    = "my-bucket-name"
    project = "my-project-id"
  }

  assert {
    condition     = output.name == "my-bucket-name"
    error_message = "Output 'name' does not match the expected value"
  }

  assert {
    condition     = output.project == "my-project-id"
    error_message = "Output 'project' does not match the expected value"
  }

  assert {
    condition     = output.location == "US"
    error_message = "Output 'location' does not match the expected value"
  }

  assert {
    condition     = output.storage_class == "STANDARD"
    error_message = "Output 'storage_class' does not match the expected value"
  }

  assert {
    condition     = output.url == "gs://my-bucket-name"
    error_message = "Output 'url' does not match the expected value"
  }

  assert {
    condition     = output.self_link == "https://www.googleapis.com/storage/v1/b/my-bucket-name"
    error_message = "Output 'self_link' does not match the expected value"
  }
}

run "verify_gcs_module_outputs_without_project" {
  command = plan

  variables {
    name    = "my-bucket-name"
    project = null
  }

  assert {
    condition     = output.name == "my-bucket-name"
    error_message = "Output 'name' does not match the expected value"
  }

  assert {
    condition     = output.project == null
    error_message = "Output 'project' does not match the expected value"
  }
}
