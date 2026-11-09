terraform {
  required_version = ">= 1.5.0"
  required_providers {
    minio = {
      source  = "aminueza/minio"
      version = "~> 2.0"
    }
  }

  backend "s3" {
    bucket                      = "tfstate"
    key                         = "dev/terraform.tfstate"
    region                      = "us-east-1"
    endpoints                   = { s3 = "http://localhost:9000" }
    access_key                  = "minio"
    secret_key                  = "minio123"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style            = true
  }
}

provider "minio" {
  minio_server   = "localhost:9000"
  minio_user     = "minio"
  minio_password = "minio123"
  minio_ssl      = false
}

module "app_infra" {
  source        = "../../modules/s3_iam"
  bucket_name   = var.bucket_name
  iam_user_name = var.iam_user_name
}