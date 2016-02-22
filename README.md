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

5. Ensure that the `.terraform` directory does not exist:

   ```
   rm -rf .terraform
   ```

5. Manually run `terraform plan` for the first time. It will prompt you for the
   environment, so just enter the one you set above:

   ```
   terraform plan
   ```

6. Manually run `terraform apply` for the first time. Again, it will prompt you
   for the environment:

   ```
   terraform apply
   ```

   It will error at the end of this step complaining it can't find a bucket,
   but this is expected so move on to the next step.

7. Manually run the remote config task, ensuring the environment name matches
   what has been entered previously:

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
