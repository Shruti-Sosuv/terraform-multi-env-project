terraform {
  backend "s3" {
    bucket       = "REPLACE_WITH_YOUR_STATE_BUCKET"
    key          = "environments/prod/terraform.tfstate"
    region       = "ap-southeast-2"
    encrypt      = true
    use_lockfile = true
  }
}
