# Terraform MinIO Infrastructure Portfolio

Provision S3 buckets, IAM users, and least-privilege policies on a local MinIO instance using Terraform. 

This project demonstrates complete Infrastructure-as-Code (IaC) workflows, including modularization, remote state management, and idempotency verification, entirely using open-source tools.

## Architecture
[Terraform CLI] --plan/apply--> [MinIO Server: Buckets + IAM]
     |
     +-- remote state --> [MinIO: tfstate bucket]

## Quick Start
1. Start MinIO via Docker: 
   `docker run --rm -d --name minio -p 9000:9000 -p 9001:9001 -e "MINIO_ROOT_USER=minio" -e "MINIO_ROOT_PASSWORD=minio123" cgr.dev/chainguard/minio:latest server /data --console-address ":9001"`
2. Log into MinIO (localhost:9001) and create a bucket named `tfstate`.
3. Navigate to the environment and deploy:
   ```bash
   cd environments/dev
   terraform init
   terraform apply
Key Decisions
Remote State: Configured to store state inside MinIO itself (simulating an AWS S3 backend). This prevents state files from being committed to Git and allows team collaboration.

Modularized: The resources are defined in modules/s3_iam, separating logic from environment-specific variables in environments/dev.

Security: The .gitignore explicitly blocks .tfstate files and .tfvars files containing potentially sensitive data.

Verified Output
Proving idempotency: Running terraform plan immediately after apply results in no changes.

https://plan-screenshot.png/

text

**Save the file (Ctrl+S).**

### Step 2: Verify your `.gitignore`
Make sure you have a file named `.gitignore` in the root folder (`C:\terraform-portfolio`). It should contain exactly this:

```text
.terraform/
*.tfstate
*.tfstate.backup
terraform.tfvars
