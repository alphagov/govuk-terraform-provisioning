# 3. Terraform State file naming and management

Date: 25/02/2016

## Status

Proposed / Prototyped

## Context

Currently a terraform run contains every resource we manage. As the scope
of this repo expands that will eventually encompass everything on GOV.UK.
We would like to reduce this scope to make both reasoning about changes and 
lessen possible impact.

## Decision

In order to isolate changes, for safety and scope, we will separate terraform
state files in to multiple files, based on a combination of project and environment.

Only one instance of Terraform should be used at a time. This means you are limited to
having a single local statefile. The tooling has been written to assume this is true.

## Consequences

We have multiple state files per environment.
