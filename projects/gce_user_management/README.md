# Google Cloud Engine user management #

## Introduction

This manages users, service accounts and their permissions on Google Compute Enginge.

Currently it assumes that the only project being managed will be `govuk_test` which is configured in the `/config/gce/gce_variables.tf` file.

## Adding users

Add the user's email address to the `members` array in `users.tf`. There are currently three IAM roles that a user can be bound to:

* **owner** this is the highest level of access. An owner can make any change as well as set up billing and modify membership of a project.
* **editor** this is the standard level of access. An editor can modify state for a project but not permissions or membership.
* **dns.admin** this is intended for use by service accounts. All it can do is modify the Google Cloud DNS for a project

## Deleting users

Remove the user from any `members` arrays they are in.
