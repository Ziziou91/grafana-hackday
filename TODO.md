# Grafana Hackday - Todo List

## Goal
Create a Grafana Cloud dashboard using the TestData datasource, managed with Terraform, with remote state stored in Vultr Object Storage.

---

## 1. Vultr Object Storage (Terraform Remote State)
- [ ] Create a Vultr Object Storage bucket to store Terraform state
- [ ] Note down the bucket name, endpoint, access key, and secret key
- [ ] Configure the Terraform S3-compatible backend pointing at Vultr Object Storage

## 2. Grafana Cloud - Gather Credentials
- [ ] Locate your Grafana Cloud stack URL (e.g. `https://<your-stack>.grafana.net`)
- [ ] Locate your Grafana Cloud stack ID / org slug
- [ ] Create or confirm a Grafana service account with sufficient permissions (Editor or Admin)
- [ ] Generate a service account token to use as `auth` in the Terraform provider

## 3. Project Structure
- [ ] Create a `main.tf` (provider config + backend)
- [ ] Create a `variables.tf` (stack URL, auth token, etc.)
- [ ] Create a `terraform.tfvars` or use environment variables for secrets
- [ ] Create a `dashboard.tf` (dashboard resource)
- [ ] Add a `.gitignore` to exclude `.tfvars`, `.tfstate`, and `.terraform/`

## 4. Terraform Configuration
- [ ] Configure the `grafana/grafana` Terraform provider
- [ ] Configure the S3 backend (Vultr-compatible) for remote state
- [ ] Add a `grafana_data_source` resource for the built-in **TestData** datasource
- [ ] Add a `grafana_dashboard` resource with a JSON dashboard definition that uses the TestData source
- [ ] Define at least one panel (e.g. a time series panel using a TestData scenario like "Random Walk")

## 5. Initialise & Deploy
- [ ] Run `terraform init` to initialise the backend and download providers
- [ ] Run `terraform plan` to verify the expected changes
- [ ] Run `terraform apply` to create the datasource and dashboard in Grafana Cloud

## 6. Verify
- [ ] Log in to Grafana Cloud and confirm the TestData datasource appears under **Connections > Data sources**
- [ ] Confirm the dashboard appears and panels render correctly
- [ ] (Optional) Check the remote state file is present in the Vultr bucket

---

## Notes
- Vultr Object Storage is S3-compatible; use the `s3` Terraform backend with the Vultr endpoint
- Never commit secrets (tokens, access keys) to version control — use env vars or a `.tfvars` file that is git-ignored
- The TestData datasource is built into Grafana but still needs to be explicitly added as a datasource resource in Terraform to reference it in dashboards
