# GOV.UK provisioning in Terraform

This repository contains the configuration to provision parts of GOV.UK on AWS
such as S3 buckets. We're using Terraform v0.8.

This is distinct from our AWS migration work (see `alphagov/govuk-aws`). We
plan to roll this repo into that one, with some updates, in time.

## Deploying your changes

When you make changes and merge them to master, you will need to deploy them.

Terraform has `plan` and `apply` steps, which should be self explanatory. There
is a [Jenkins
job](https://deploy.publishing.service.gov.uk/job/Deploy_Terraform_Project/) in
all three environments named "Deploy Terraform Project" that will deploy
changes that are on master.

It requires:

- The project name (for example, `user_management` or `asset-manager`).
- Your AWS access key and secret key for the specific environment.
- Whether you're running a `plan` or an `apply`.

If you don't have AWS access keys yourself and are asked to do this by someone
while on 2ndline, there are shared credentials in the 2ndline password store
under `aws/`, separated by environment.

# Project Directories

The projects located in `old-projects` were built with Terraform `0.6` and are being left as-is until
we have a need to update them. All new projects should work with at least Terraform `0.7` and be located in
`projects`
