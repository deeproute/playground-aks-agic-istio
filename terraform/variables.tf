variable "region" {
  description = "Region of the resource group."
  type        = string
}

variable "resource_group_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_address_spaces" {
  type = list(string)
}

variable "vnet_subnets" {
  description = "List of objects that will create subnets"
  type = list(object({
    name             = string
    vnet_name        = string
    address_prefixes = list(string)
  }))
  default = []
}

variable "cluster_name" {
  type = string
}

variable "private_cluster_enabled" {
  type    = bool
  default = false
}

variable "kubernetes_version" {
  type = string
}

variable "node_count" {
  type    = number
  default = 1
}

variable "network_plugin" {
  type    = string
  default = "kubenet"
}

variable "network_policy" {
  type    = string
  default = "calico"
}

variable "node_pools" {
  type = list(object({
    name                   = string
    orchestrator_version   = string
    vm_size                = string
    enable_host_encryption = bool
    os_disk_size_gb        = number
    os_disk_type           = string
    vnet_name              = string
    subnet_name            = string
    node_count             = number
    enable_auto_scaling    = bool
    min_count              = number
    max_count              = number
    max_pods               = number
    availability_zones     = list(string)
    enable_public_ip       = bool
    ultra_ssd_enabled      = bool
    labels                 = map(string)
    taints                 = list(string)
    mode                   = string
  }))
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the resource."
}

variable "app_gw_name" {
  type = string
}

variable "app_gw_vnet_name" {
  type = string
}

variable "app_gw_vnet_subnet_name" {
  type = string
}

variable "app_gw_sku" {
  type    = string
  default = "WAF_v2"
}

variable "app_gw_backend_pool_name" {
  type = string
}

variable "app_gw_backend_pool_ip_addresses" {
  type = list(string)
}