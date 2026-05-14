variable "grafana_url" {
  description = "The URL of your Grafana Cloud stack, e.g. https://<your-stack>.grafana.net"
  type        = string
}

variable "grafana_service_account_token" {
  description = "Service account token used to authenticate with Grafana Cloud"
  type        = string
  sensitive   = true
}

variable "dashboard_folder" {
  description = "Name of the Grafana folder to place the dashboard in"
  type        = string
  default     = "Hackday"
}
