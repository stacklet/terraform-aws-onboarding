terraform {
  backend "s3" {
    bucket  = "stacklet-terraform-ci-backend"
    key     = "tfstate/dev/terraform-aws-onboarding/tfstate.json"
    region  = "us-east-2"
    profile = "Test-Runner"
  }

  required_version = "~> 1.11.3"
}
