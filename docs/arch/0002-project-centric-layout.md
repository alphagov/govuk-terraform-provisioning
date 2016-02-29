# 2. Project-centric Terraform layout

Date: 25/02/2016

## Status

Proposed / Prototyped

## Context

We would like to have logical groupings of code that allow both separation of
reusable modules and combines each projects code and configuration in to a
consistent but isolated unit.

## Decision

Store units of code and configuration in directories. The exact layout is still
being iterated on and will be added here as an example once a MVP is ready.

## Consequences

The root directory of the terraform module will contain directories representing 
projects and modules.
