variable "gcp_project_id" {
  description = "GCP project ID"
  type        = string
  default     = "project-75c809f3-652f-4ed3-a4c"
}

variable "gcp_region" {
  description = "GCP region to deploy resources"
  type        = string
  default     = "us-central1"
}

variable "gcp_zone" {
  description = "GCP zone to deploy the instance"
  type        = string
  default     = "us-central1-a"
}

variable "machine_type" {
  description = "GCP Compute Engine machine type"
  type        = string
  default     = "e2-micro"
}

variable "ssh_allowed_cidr" {
  description = "CIDR range allowed to SSH into the instance"
  type        = string
  default     = "0.0.0.0/0"
}
