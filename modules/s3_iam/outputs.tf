output "bucket_name" { value = minio_s3_bucket.app_bucket.bucket }
output "iam_user_name" { value = minio_iam_user.app_user.name }
output "policy_name" { value = minio_iam_policy.app_policy.name }