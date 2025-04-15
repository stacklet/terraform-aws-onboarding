terraform {
  backend "s3" {
    bucket  = "stacklet-terraform-ci-backend"
    key     = "tfstate/dev/terraform-aws-onboarding/org-read"
    region  = "us-east-2"
    profile = "Test-Runner"
  }
}
