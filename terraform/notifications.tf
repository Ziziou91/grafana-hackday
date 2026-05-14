resource "grafana_contact_point" "jira" {
  name = "Jira-Bug-Integration"

  webhook {
    url         = var.jira_webhook_url
    http_method = "POST"
    max_alerts  = 1
    settings = {
      "X-Automation-Webhook-Token" = var.jira_webhook_secret
    }
  }
}

resource "grafana_notification_policy" "hackday" {
  group_by      = ["alertname"]
  contact_point = "Google-Chat-Integration"

  policy {
    matcher {
      label = "alert_name"
      match = "="
      value = ""
    }
    contact_point = "Google-Chat-Integration"
    continue      = true
  }

  policy {
    matcher {
      label = "alert_name"
      match = "="
      value = ""
    }
    contact_point = grafana_contact_point.jira.name
  }
}
