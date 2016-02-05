# GOV.UK provisioning in Terraform

This repository contains the configuration to provision parts of GOV.UK.
We're using Terraform as an experiment.

## Installing Terraform

```
brew install terraform
```

## Setting up credentials

Create a file called `secrets.tfvars` which looks like this:

```
aws_access_key = "akia_access_key"
aws_secret_key = "secret_key"
```

## Doing a dry-run

```
terraform plan -var-file="secrets.tfvars" .
```

## Changing things

```
terraform apply -var-file="secrets.tfvars" .
```

## Making a graph

```
terraform graph . | dot -Tpng > graph.png
```
