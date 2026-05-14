terraform {
  required_version = ">= 1.3.0"

  required_providers {
    grafana = {
      source  = "grafana/grafana"
      version = "~> 3.0"
    }
  }

  # backend "s3" {
  #   # Uncomment and configure this block when you are ready to use Vultr Object Storage for remote state.
  #   #
  #   # terraform init \
  #   #   -backend-config="bucket=<your-bucket-name>" \
  #   #   -backend-config="key=grafana-hackday/terraform.tfstate" \
  #   #   -backend-config="endpoint=https://<region>.vultrobjects.com" \
  #   #   -backend-config="access_key=<vultr-access-key>" \
  #   #   -backend-config="secret_key=<vultr-secret-key>" \
  #   #   -backend-config="region=us-east-1"
  #
  #   bucket                      = "REPLACE_ME"
  #   key                         = "grafana-hackday/terraform.tfstate"
  #   region                      = "us-east-1"
  #   endpoint                    = "REPLACE_ME"  # e.g. https://ewr1.vultrobjects.com
  #   skip_credentials_validation = true
  #   skip_metadata_api_check     = true
  #   skip_region_validation      = true
  #   force_path_style            = true
  # }
}

provider "grafana" {
  url  = var.grafana_url
  auth = var.grafana_service_account_token
}
