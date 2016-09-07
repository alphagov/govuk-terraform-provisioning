# Private_S3_Bucket

## Introduction

This creates an S3 bucket which has a read-write user and no public access.

If you're creating a bucket which will hold any sensitive data it is recommended
to use this module.


### Permanently deleting objects in s3:

To permanently delete an object you must first set the object to expire with the `expiration` argument within a lifecycle rule.
```
expiration {
  days = 3
}
```
Once the object has expired, it disappears from the bucket but still exists as a `noncurrent` version with a delete marker.
Please note costs still apply for `noncurrent` objects.

To permanently remove the expired object, you'll need to use the `noncurrent_version_expiration` argument.
```
noncurrent_version_expiration {
  days = 1
}
```
The statement above will permanently delete an s3 object after 1 day of being expired.