variable "name" {
  description = "The name of the bucket."
  type        = string
}

variable "location" {
  description = "The GCS location."
  type        = string
  default     = "US"
}

variable "project" {
  description = "The ID of the project in which the resource belongs."
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "When deleting a bucket, this boolean option will delete all contained objects."
  type        = bool
  default     = false
}

variable "storage_class" {
  description = "The Storage Class of the new bucket. Supported values include: STANDARD, MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE."
  type        = string
  default     = "STANDARD"
}

variable "uniform_bucket_level_access" {
  description = "Enables Uniform Bucket-Level Access."
  type        = bool
  default     = null
}

variable "public_access_prevention" {
  description = "Prevents public access to a bucket."
  type        = string
  default     = null
}

variable "rpo" {
  description = "Recovery Point Objective (RPO) of this bucket. Can be ASYNC_TURBO or DEFAULT."
  type        = string
  default     = null
}

variable "enable_object_retention" {
  description = "Enables object retention on a new bucket."
  type        = bool
  default     = null
}

variable "labels" {
  description = "A map of key/value label pairs to assign to the bucket."
  type        = map(string)
  default     = null
}

variable "autoclass" {
  description = "The bucket's Autoclass configuration."
  type = object({
    enabled                = bool
    terminal_storage_class = optional(string, null)
  })
  default = null
}

variable "cors" {
  description = "The bucket's Cross-Origin Resource Sharing (CORS) configuration."
  type = list(object({
    origin          = optional(list(string), null)
    method          = optional(list(string), null)
    response_header = optional(list(string), null)
    max_age_seconds = optional(number, null)
  }))
  default = null
}

variable "custom_placement_config" {
  description = "The bucket's custom placement configuration."
  type = object({
    data_locations = list(string)
  })
  default = null
}

variable "encryption" {
  description = "The bucket's encryption configuration."
  type = object({
    default_kms_key_name = string
  })
  default = null
}

variable "hierarchical_namespace" {
  description = "The bucket's hierarchical namespace configuration."
  type = object({
    enabled = bool
  })
  default = null
}

variable "lifecycle_rule" {
  description = "The bucket's lifecycle rules."
  type = list(object({
    action = object({
      type          = string
      storage_class = optional(string, null)
    })
    condition = object({
      age                        = optional(number, null)
      created_before             = optional(string, null)
      with_state                 = optional(string, null)
      matches_storage_class      = optional(list(string), null)
      matches_prefix             = optional(list(string), null)
      matches_suffix             = optional(list(string), null)
      num_newer_versions         = optional(number, null)
      custom_time_before         = optional(string, null)
      days_since_custom_time     = optional(number, null)
      days_since_noncurrent_time = optional(number, null)
      noncurrent_time_before     = optional(string, null)
    })
  }))
  default = null
}

variable "logging" {
  description = "The bucket's Access & Storage Logs configuration."
  type = object({
    log_bucket        = string
    log_object_prefix = optional(string, null)
  })
  default = null
}

variable "retention_policy" {
  description = "Configuration of the bucket's data retention policy."
  type = object({
    is_locked        = optional(bool, null)
    retention_period = number
  })
  default = null
}

variable "soft_delete_policy" {
  description = "The bucket's soft delete policy configuration."
  type = object({
    retention_duration_seconds = optional(number, null)
  })
  default = null
}

variable "versioning" {
  description = "The bucket's Versioning configuration."
  type = object({
    enabled = bool
  })
  default = null
}

variable "website" {
  description = "Configuration if the bucket acts as a website."
  type = object({
    main_page_suffix = optional(string, null)
    not_found_page   = optional(string, null)
  })
  default = null
}
