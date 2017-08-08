# GOV.UK provisioning in Terraform

This repository contains the configuration to provision parts of GOV.UK.
We're using Terraform as an experiment.

## Installing Terraform

```
brew update
brew install terraform
```

## Setting up credentials

Export your AWS credentials as environment variables:

```
export AWS_ACCESS_KEY_ID='ACCESS_KEY'
export AWS_SECRET_ACCESS_KEY='SECRET_KEY'
```

## Setting up the environment

Export the environment applicable to your credentials:

```
export DEPLOY_ENV=<environment>
```

## Setting up your project

Export the project you're working on as an environment variable. Projects are
stored under the `projects` directory:

```
export PROJECT_NAME=<project>
```

## Show potential changes

```
bundle install
bundle exec rake plan
```

## Apply changes

```
bundle exec rake apply
```

## Making a graph

```
bundle exec rake graph
```

# Project Directories

The projects located in `old-projects` were built with Terraform `0.6` and are being left as-is until
we have a need to update them. All new projects should work with at least Terraform `0.7` and be located in
`projects`

# Creating a fresh environment in AWS

Please note this is still experimental.

1. Create the account in AWS
2. Log in and generate root account access keys
3. Export the AWS credentials as environment variables:

   ```
   export AWS_ACCESS_KEY_ID='ACCESS_KEY'
   export AWS_SECRET_ACCESS_KEY='SECRET_KEY'
   ```

4. Export the environment name you wish to create:

   ```
   export DEPLOY_ENV=<environment>
   ```

5. Run the rake task which bootstraps the environment, using the project name
   for the base infrastructure on which you are building on:

  ```
  bundle install
  export PROJECT_NAME=aws_bootstrap
  bundle exec rake bootstrap
  ```

6. This will error the first time, but run it again and it will do the right
   thing.

7. You should now be able to run per project rake tasks as required.

# Development

If you don't have access to the GOV.UK S3 buckets which store Terraform state for the various environments, but you want to run the standard Rake tasks to plan/apply changes, you'll need to manually create an S3 bucket (with the appropriate environment suffix, e.g. "-test") and an IAM admin user and then set the following environment variables:

    TERRAFORM_STATE_S3_BUCKET_REGION=<s3-bucket-region>
    TERRAFORM_STATE_S3_BUCKET_NAME_PREFIX=<s3-bucket-name-prefix>

Here's an example of running one of the Rake tasks assuming we have a bucket named "my-s3-bucket-test" in the "eu-west-2" region:

    $ TERRAFORM_STATE_S3_BUCKET_REGION=eu-west-2 TERRAFORM_STATE_S3_BUCKET_NAME_PREFIX=my-s3-bucket  PROJECT_NAME=<project-name> DEPLOY_ENV=test bundle exec rake plan
