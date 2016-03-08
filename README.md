# GOV.UK provisioning in Terraform

This repository contains the configuration to provision parts of GOV.UK.
We're using Terraform as an experiment.

## Installing Terraform

```
brew install terraform
```

## Setting up credentials

Export your AWS credentials as environment variables:

```
export AWS_ACCESS_KEY_ID='ACCESS_KEY'
export AWS_SECRET_ACCESS_KEY='SECRET_KEY'
```

## Show potential changes

```
make plan
```

## Apply changes

```
make apply
```

## Making a graph

```
make graph
```

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
