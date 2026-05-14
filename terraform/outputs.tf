output "dashboard_url" {
  description = "Direct URL to the deployed dashboard"
  value       = "${var.grafana_url}/d/${grafana_dashboard.hackday.dashboard_id}"
}

output "datasource_uid" {
  description = "UID of the TestData datasource"
  value       = grafana_data_source.testdata.uid
}
