# GOV.UK Infrastructure's AWS account

## Initial setup

AWS [CloudTrail](https://aws.amazon.com/cloudtrail/) has been set up to log
all account activity to an S3 bucket.

A basic password policy has been set in IAM (Identity and Access Management).

We've deactivated security tokens in parts of the US and Asia Pacific
that we shouldn't need to use.
