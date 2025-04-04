# Terraform modules for Stacklet platform onboarding on AWS

This repository contains modules to create the necessary resources for the
Stacklet platform to operate on AWS accounts.

## Account discovery access

The [org-read](./org-read/README.md) module creates the necessary IAM role/permissions for
Stacklet to read accounts in the organization.

This must be run in the root AWS account for the organization.


## Stacklet account access

The [access](./access/README.md) module creates the necessary setup for
Stacklet to discover resources and perform policy execution in an AWS account.

This must be run in each account where Stacklet should operate on.
