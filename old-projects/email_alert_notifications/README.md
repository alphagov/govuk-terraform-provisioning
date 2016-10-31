# Email Alert Notifications

This project sets up an S3 bucket and a Lambda that parses files,
extracts `data-govuk-request-id` and renames the file accordingly as
either:

    travel-advice-alerts/<data-govuk-request-id>.msg

or if the file doesn't contain a `data-govuk-request-id`

    no-request-id/<uuid>.msg

## Manual Steps

There is a manual step required for this 'app'.

* An SES domain with a RuleSet containing an action that writes to the S3
bucket (`govuk-email-alert-notifications`). An address on this domain will be
subscribed to all of the travel advice country alerts

