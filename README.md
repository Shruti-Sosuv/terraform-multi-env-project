# Terraform Multi-Environment AWS Infrastructure

A study project that creates separate Dev and Prod environments using reusable Terraform code.

## Architecture

- One VPC and public subnet per environment
- Internet Gateway and route table per environment
- One EC2 instance per environment
- Reusable module in `modules/network-ec2`
- S3 remote state with native S3 lockfiles
- Separate state keys for Dev and Prod
- GitHub Actions runs `terraform fmt` and `terraform validate` on pull requests

> Cost note: EC2, EBS, public IPv4 addresses, and other AWS resources may incur charges. Destroy resources after practice. Do not use this example as-is for production workloads.

## Prerequisites

- Terraform 1.10 or later (for S3 native lockfiles)
- AWS CLI configured with credentials that can create the required resources
- Git
- An AWS account and an AWS region

The examples use `ap-southeast-2` (Sydney).

## 1. Create the remote-state bucket (bootstrap)

The S3 bucket must exist before the Dev/Prod backends can initialize. Bootstrap it first using a unique bucket name.

```bash
cd bootstrap
terraform init
terraform apply -var="state_bucket_name=YOUR-GLOBALLY-UNIQUE-BUCKET-NAME"
```

Save the bucket name. The bootstrap configuration enables versioning, encryption, and public-access blocking.

## 2. Configure each backend

In both `environments/dev/backend.tf` and `environments/prod/backend.tf`, replace `REPLACE_WITH_YOUR_STATE_BUCKET` with the bucket name created above.

The Dev and Prod environments use different state keys. Do not share a state key between environments.

## 3. Deploy Dev

```bash
cd ../environments/dev
terraform init
terraform plan -var="allowed_ssh_cidr=YOUR_PUBLIC_IP/32"
terraform apply -var="allowed_ssh_cidr=YOUR_PUBLIC_IP/32"
```

To find your public IP, use a trusted IP-check service. Do not set the SSH CIDR to `0.0.0.0/0`.

## 4. Deploy Prod

```bash
cd ../prod
terraform init
terraform plan -var="allowed_ssh_cidr=YOUR_PUBLIC_IP/32"
terraform apply -var="allowed_ssh_cidr=YOUR_PUBLIC_IP/32"
```

Run these commands from `environments/prod` (full path: `terraform-multi-env-project/environments/prod`).

## 5. Review outputs

```bash
terraform output
```

## 6. Clean up

Destroy Dev and Prod separately, using the same variables used during apply:

```bash
cd environments/dev
terraform destroy -var="allowed_ssh_cidr=YOUR_PUBLIC_IP/32"

cd ../prod
terraform destroy -var="allowed_ssh_cidr=YOUR_PUBLIC_IP/32"
```

After both environments are destroyed, remove the backend configuration from use and destroy the bootstrap bucket only if it is empty and you no longer need its state history. The bootstrap bucket's own state is local unless you configure a separate backend for it.

## Folder structure

```text
terraform-multi-env-project/
├── .github/workflows/terraform-checks.yml
├── bootstrap/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── environments/
│   ├── dev/
│   │   ├── backend.tf
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── prod/
│       ├── backend.tf
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── modules/network-ec2/
    ├── main.tf
    ├── variables.tf
    └── outputs.tf
```

## Pull request workflow

1. Create a feature branch.
2. Add the project files.
3. Push the branch to GitHub.
4. Open a PR against `main`.
5. Review the Actions checks and Terraform changes.
6. Merge only after review.

The included GitHub Actions workflow runs formatting and validation. It deliberately does not run `terraform apply` or require AWS credentials.
