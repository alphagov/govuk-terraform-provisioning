# PairedUser

## Introduction

The terribly named `PairedUser` module creates an S3 bucket and two users,
one with the ability to read, write and delete objects to the bucket and
one that grants readonly permissions.

The common case for this is where we export files to S3 for backup/storage
but want to let the public to read them.

New names for this module are very welcome.
