output "state_bucket_name" {
  description = "S3 bucket name to configure in the Dev and Prod backend blocks."
  value       = aws_s3_bucket.terraform_state.bucket
}
