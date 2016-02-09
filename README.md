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
