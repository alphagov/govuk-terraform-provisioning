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

# Creating a fresh environment

1. Create a new directory in this repo named after the environment you wish to
   create, matching the naming scheme of the account in AWS. Create the
   terraform configuration files in this directory.
2. Create the account in AWS
3. Log in and generate root account access keys
4. Export the AWS credentials as environment variables:

   ```
   export AWS_ACCESS_KEY_ID='ACCESS_KEY'
   export AWS_SECRET_ACCESS_KEY='SECRET_KEY'
   ```

5. Manually run `terraform plan` for the first time:

   ```
   terraform plan <environment>
   ```

6. Manually run `terraform apply` for the first time:

   ```
   terraform apply <environment>
   ```

7. Manually run the remote config task, ensuring the environment name matches
   what has been set up previously, and changing any variables as required:

   ```
   terraform remote config -backend=s3 \
     -backend-config='acl=private' \
     -backend-config='bucket=govuk-terraform-state-<environment>' \
     -backend-config='encrypt=true' \
     -backend-config='key=terraform.tfstate' \
     -backend-config='region=eu-west-1'
   ```

8. The statefile should now have been automatically removed, and you should be
   able to run the `make` commands as specified above to make any further
   changes to the environment.
