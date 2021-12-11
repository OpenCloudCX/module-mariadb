variable "namespace" {
  type    = string
  default = "anchore-engine"
}

variable "dns_zone" {
  type    = string
  default = "opencloudcx.internal"
}

variable "helm_chart" {
  type    = string
  default = "https://charts.bitnami.com/bitnami"
}

variable "helm_chart_name" {
  type    = string
  default = "mariadb"
}

variable "helm_version" {
  type    = string
  default = "10.0.1"
}

variable "helm_timeout" {
  description = "Timeout value to wait for helm chart deployment"
  type        = number
  default     = 600
}

variable "stack" {
  type    = string
  default = ""
}