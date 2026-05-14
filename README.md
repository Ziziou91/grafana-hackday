# grafana-hackday

Grafana Cloud dashboards and alerts managed with Terraform, with remote state stored in Vultr Object Storage.

## Getting started

### 1. Set up credentials

Copy both example files and fill in the real values (get them from a teammate):

```zsh
cp terraform/terraform.tfvars.example terraform/terraform.tfvars
cp terraform/backend.tfvars.example terraform/backend.tfvars
```

Edit `terraform.tfvars` with your Grafana service account token.  
Edit `backend.tfvars` with the Vultr S3 access key and secret key.

### 2. Initialise Terraform

```zsh
cd terraform
terraform init -backend-config=backend.tfvars
```

### 3. Plan and apply

```zsh
terraform plan
terraform apply
```

## Updating the dashboard

1. Export dashboard JSON from Grafana → save to `terraform/dashboards/hackday.json`
2. Clean the export:
   ```zsh
   python3 scripts/clean_dashboard.py terraform/dashboards/hackday.json --replace-datasource bflygz5msh0cga TestData
   ```
3. Apply:
   ```zsh
   cd terraform && terraform apply -auto-approve
   ```
