# user_management project

## Introduction

This terraform project controls the user groups and accounts we deploy to AWS.

### Adding new users and assigning them to a group

New users should be added in the [users.tf](/projects/user_management/resources/integration/users.tf)
file for each environment the account should be present in.

Once they have been added to the .tf file you should add them to the `aws_iam_group_membership` for the
team and environment they should be granted access to.
See [custom_formats.tf](/projects/user_management/resources/integration/custom_formats.tf) for an example.

### Adding new groups

New groups should be added in [groups.tf](/projects/user_management/resources/groups.tf) file.

### Deleting users

Terraform maintains a state of all the resources it manages so deleting a user
only requires you to remove them from the `users.tf` and group membership files for
each environment.
