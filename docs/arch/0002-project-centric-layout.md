# 2. Project-centric Terraform layout

Date: 25/02/2016

## Status

Proposed / Prototyped

## Context

We would like to have logical groupings of code that allow both separation of
reusable modules and combines each projects code and configuration in to a
consistent but isolated unit.

## Decision

Store units of code and configuration in directories. The initial version of the layout is still
being iterated on but currently expects your directory structure to look like the below:

    modules                         # each local module should be placed under here
    modules/networking/             # resource containing tf files should be placed here
    modules/networking/main.tf
    modules/networking/overlays.tf
    modules/networking/README.md


    projects                                    # each project has a directory under here
    projects/master_dbs/
    projects/master_dbs/resources               # common resources should be placed here
    projects/master_dbs/resources/main.tf
    projects/master_dbs/resources/rds.tf
    projects/master_dbs/resources/production/   # environment specific resources should be placed here
    projects/master_dbs/resources/production/read-replicas.tf

## Consequences

The root directory of the terraform module will contain directories containing 
projects and modules.
