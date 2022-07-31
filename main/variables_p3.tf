variable "account_replication_type" {
    description = "Type of the account_replication_type"
    type = string
    default     = "GRS"
}

variable "account_tier" {
    description = "Status of the account_tier"
    type = string
    default     = "Standard"
}

variable "pk_storage" {
    description = "Name of the storage account"
    type = string
    default     = "priyastorageaccountname"
}

variable "pk_name" {
    description = "Name of the resource group"
    type = string
    default     = "techslate_pk_keyv"
}

variable "location" {
    description = "location where the resource will be created"
    type    = string
    default = "eastus"
}

variable "tags" {
    description = "tags for the resource"
    type    = map(string)
    default =  {
        "environment" = "dev"
        "source" = "terraform"
  }
}

variable "secret_name" {
  description = "KV secret name"
  default     = "default-secret-name"
  type        = string
}

variable "secret_names" {
  description = "KV secret names - list"
  type        = map(string)
  default     = {
    value = "priyakeyvaultsecret"
  }
}

variable "secret_value" {
  description = "KV secret value"
  default     = "default-secret-value"
  type        = string
}