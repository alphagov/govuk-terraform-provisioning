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
