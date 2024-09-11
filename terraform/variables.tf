variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
  default = "aks_cgi_rg"
}
variable "location" {
  type        = string
  description = "Resources location in Azure"
  default = "EAST US"
}
variable "cluster_name" {
  type        = string
  description = "AKS name in Azure"
  default = "test_aks"
}
variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
  default = "1.30.3"
}
variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes"
  default = 1
}
variable "acr_name" {
  type        = string
  description = "ACR name"
  default = "testacrcgi"
}

variable "dns_prefix_name" {
    default = "aksprefix"
  
}