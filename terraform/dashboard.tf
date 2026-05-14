# Create a folder in Grafana to organise the dashboard
resource "grafana_folder" "hackday" {
  title = var.dashboard_folder
}

# Register the built-in TestData datasource so it can be referenced in dashboards
resource "grafana_data_source" "testdata" {
  type = "grafana-testdata-datasource"
  name = "TestData"

  # TestData is built-in, so no external URL or credentials are needed
}

# Dashboard with a single Time Series panel driven by the TestData "Random Walk" scenario
resource "grafana_dashboard" "hackday" {
  folder      = grafana_folder.hackday.uid
  config_json = jsonencode({
    title       = "Hackday - TestData Demo"
    uid         = "hackday-testdata-demo"
    schemaVersion = 39
    refresh     = "5s"
    time = {
      from = "now-15m"
      to   = "now"
    }
    panels = [
      {
        id    = 1
        title = "Random Walk"
        type  = "timeseries"
        gridPos = {
          h = 10
          w = 24
          x = 0
          y = 0
        }
        datasource = {
          type = grafana_data_source.testdata.type
          uid  = grafana_data_source.testdata.uid
        }
        targets = [
          {
            refId          = "A"
            scenarioId     = "random_walk"
            alias          = "Random Walk"
            seriesCount    = 3
            datasource = {
              type = grafana_data_source.testdata.type
              uid  = grafana_data_source.testdata.uid
            }
          }
        ]
        options = {
          legend = {
            displayMode = "list"
            placement   = "bottom"
          }
          tooltip = {
            mode = "single"
          }
        }
        fieldConfig = {
          defaults = {
            color = {
              mode = "palette-classic"
            }
          }
          overrides = []
        }
      }
    ]
  })
}
