variable "azure_region" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "Central US"
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
  default     = "Standard_B2ps_v2"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "ssh_allowed_cidr" {
  description = "CIDR block allowed to SSH into the VM"
  type        = string
  default     = "0.0.0.0/0"
}

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "nginx-rg"
}
