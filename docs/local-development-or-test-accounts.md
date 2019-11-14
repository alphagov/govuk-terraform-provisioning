# Developing locally, with our AWS test environment and your own access keys

Sometimes you might want to develop locally and `plan` and `apply` your changes
to our test environment. There is not a Jenkins job for this, and you will need
your own AWS access keys.

## Using the `test` environment

1. Install Terraform. We're using
   [v0.8.1](https://github.com/alphagov/govuk-terraform-provisioning/blob/master/.terraform-version#L1)
   in this repo, so install from a release binary at https://releases.hashicorp.com/terraform/.

2. Export your AWS credentials as environment variables.

        export AWS_ACCESS_KEY_ID='ACCESS_KEY'
        export AWS_SECRET_ACCESS_KEY='SECRET_KEY'

3. Export the environment applicable to your credentials, for example `test`.

        export DEPLOY_ENV=<environment>

4. Export the environment variable for the project you're working on.

        export PROJECT_NAME=<project>

5. Run `bundle install` in the repo.

6. Use `terraform plan`, wrapped by a Rake task, to show potential changes.

        bundle exec rake plan

7. Apply your changes.

        bundle exec rake apply

## Creating a fresh environment in AWS

Please note this is still experimental.

1. Create the account in AWS
2. Log in and generate root account access keys
3. Export the AWS credentials as environment variables:

        export AWS_ACCESS_KEY_ID='ACCESS_KEY'
        export AWS_SECRET_ACCESS_KEY='SECRET_KEY'

4. Export the environment name you wish to create:

        export DEPLOY_ENV=<environment>

5. Run the rake task which bootstraps the environment, using the project name
   for the base infrastructure on which you are building on:

        bundle install
        export PROJECT_NAME=aws_bootstrap
        bundle exec rake bootstrap

6. This will error the first time, but run it again and it will do the right
   thing.

7. You should now be able to run per project rake tasks as required.

## Developing without access to the GOV.UK S3 buckets

If you don't have access to the GOV.UK S3 buckets which store Terraform state
for the various environments, but you want to run the standard Rake tasks to
plan/apply changes, you'll need to manually create an S3 bucket (with the
appropriate environment suffix, e.g. "-test") and an IAM admin user and then
set the following environment variables:

    TERRAFORM_STATE_S3_BUCKET_REGION=<s3-bucket-region>
    TERRAFORM_STATE_S3_BUCKET_NAME_PREFIX=<s3-bucket-name-prefix>

Here's an example of running one of the Rake tasks assuming we have a bucket
named "my-s3-bucket-test" in the "eu-west-2" region:

    $ TERRAFORM_STATE_S3_BUCKET_REGION=eu-west-2 TERRAFORM_STATE_S3_BUCKET_NAME_PREFIX=my-s3-bucket  PROJECT_NAME=<project-name> DEPLOY_ENV=test bundle exec rake plan
