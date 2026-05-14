# Folder for alert rules (separate from the dashboard folder)
resource "grafana_folder" "hackday_alerts" {
  title = "Hackday Alerts"
}

resource "grafana_rule_group" "hackday" {
  name             = "hackday-eval-group-v2"
  folder_uid       = grafana_folder.hackday_alerts.uid
  interval_seconds = 60

  rule {
    uid            = "efm1nj5clgni8e"
    name           = "CPU Utilization %"
    condition      = "C"
    for            = "0s"
    no_data_state  = "NoData"
    exec_err_state = "Error"
    is_paused      = false

    annotations = {
      __dashboardUid__ = "ahdbjk"
      __panelId__      = "6"
      summary          = "🚨 CRITICAL: CPU Utilization > 90%"
      description      = "The client's web application is experiencing a massive CPU spike. Auto-remediation protocols are on standby."
    }

    labels = {
      alert_name = ""
    }

    notification_settings {
      contact_point = "Google-Chat-Integration"
    }

    data {
      ref_id = "A"
      relative_time_range {
        from = 600
        to   = 0
      }
      datasource_uid = grafana_data_source.testdata.uid
      model = jsonencode({
        datasource = {
          type = "grafana-testdata-datasource"
          uid  = grafana_data_source.testdata.uid
        }
        refId      = "A"
        scenarioId = "random_walk"

        # DEMO SABOTAGE POINT: Change this 50 to a 95 during your presentation!
        startValue    = 50
        spread        = 5
        min           = 10
        max           = 100
        instant       = false
        range         = true
        intervalMs    = 1000
        maxDataPoints = 43200
      })
    }

    data {
      ref_id = "B"
      relative_time_range {
        from = 0
        to   = 0
      }
      datasource_uid = "__expr__"
      model = jsonencode({
        refId      = "B"
        type       = "reduce"
        expression = "A"
        reducer    = "last"
        datasource = {
          type = "__expr__"
          uid  = "__expr__"
        }
        intervalMs    = 1000
        maxDataPoints = 43200
      })
    }

    data {
      ref_id = "C"
      relative_time_range {
        from = 0
        to   = 0
      }
      datasource_uid = "__expr__"
      model = jsonencode({
        refId      = "C"
        type       = "threshold"
        expression = "B"
        datasource = {
          type = "__expr__"
          uid  = "__expr__"
        }
        intervalMs    = 1000
        maxDataPoints = 43200
        conditions = [
          {
            evaluator = { type = "gte", params = [90] }
            operator  = { type = "and" }
            query     = { params = ["C"] }
            reducer   = { type = "last", params = [] }
            type      = "query"
          }
        ]
      })
    }
  }
}
