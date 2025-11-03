variable "resource_group_name" {
  type = string
  description = "Existing RG to deploy into"
}

variable "location" {
  type        = string
  default     = australiaeast
  description = "Location; defaults to RG location if null"
}

variable "name_prefix" {
  type = string
  default = "homelab-commerce-mvp"
}

variable "web_app_name" {
  type = string
}

variable "sku_name" {
  type    = string
  default = "B1"
  description = "Plan SKU (F1/B1/P1v3 etc.)"
}

variable "os_type" {
  type    = string
  default = "Linux" # or "Windows"
}
