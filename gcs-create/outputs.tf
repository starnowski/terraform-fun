output "bucket" {
  description = "The bucket resource object."
  value       = google_storage_bucket.bucket
}

output "name" {
  description = "The name of the bucket."
  value       = google_storage_bucket.bucket.name
}

output "url" {
  description = "The base URL of the bucket in the format gs://<bucket-name>."
  value       = google_storage_bucket.bucket.url
}

output "self_link" {
  description = "The URI of the created resource."
  value       = google_storage_bucket.bucket.self_link
}

output "project" {
  description = "The project ID of the bucket."
  value       = google_storage_bucket.bucket.project
}

output "location" {
  description = "The location of the bucket."
  value       = google_storage_bucket.bucket.location
}

output "storage_class" {
  description = "The storage class of the bucket."
  value       = google_storage_bucket.bucket.storage_class
}
