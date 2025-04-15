terraform {
  backend "s3" {
    bucket  = "stacklet-terraform-ci-backend"
    key     = "tfstate/dev/terraform-aws-onboarding/access"
    region  = "us-east-2"
    profile = "Test-Runner"
  }
}
