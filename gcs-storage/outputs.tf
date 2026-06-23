output "bucket" {
  description = "The bucket resource object."
  value       = module.gcs_create.bucket
}

output "name" {
  description = "The name of the bucket."
  value       = module.gcs_create.name
}

output "url" {
  description = "The base URL of the bucket in the format gs://<bucket-name>."
  value       = module.gcs_create.url
}

output "self_link" {
  description = "The URI of the created resource."
  value       = module.gcs_create.self_link
}

output "project" {
  description = "The project ID of the bucket."
  value       = module.gcs_create.project
}

output "location" {
  description = "The location of the bucket."
  value       = module.gcs_create.location
}

output "storage_class" {
  description = "The storage class of the bucket."
  value       = module.gcs_create.storage_class
}
