resource "grafana_folder" "hackday" {
  title = var.dashboard_folder
}

resource "grafana_data_source" "testdata" {
  type = "grafana-testdata-datasource"
  name = "TestData"

}

resource "grafana_dashboard" "hackday" {
  folder      = grafana_folder.hackday.uid
  config_json = file("${path.module}/dashboards/hackday.json")

  lifecycle {
    replace_triggered_by = [terraform_data.dashboard_json]
  }
}

# Forces replacement when the dashboard JSON changes, since the v2 API
# rejects modifications and requires a fresh create instead.
resource "terraform_data" "dashboard_json" {
  input = filesha256("${path.module}/dashboards/hackday.json")
}
