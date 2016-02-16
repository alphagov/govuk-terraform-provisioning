variable "elasticsearch_snapshots_bucket_name" {
    type = "string"
    default = "govuk-api-elasticsearch-snapshots-integration"
}

resource "aws_s3_bucket" "elasticsearch_snapshots_bucket" {
    bucket = "${var.elasticsearch_snapshots_bucket_name}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Allow public read-only access",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${var.elasticsearch_snapshots_bucket_name}/*"
    }
  ]
}
EOF

    tags {
        Environment = "Integration"
        Team = "Finding things"
    }
}

resource "aws_iam_user" "govuk_api_elasticsearch_snapshots_user" {
    name = "govuk-api-elasticsearch-snapshots"
}

resource "aws_iam_policy" "govuk_api_elasticsearch_snapshots_policy" {
    name = "govuk-api-elasticsearch-snapshots-policy"
    description = "API Elasticsearch snapshots: S3 bucket write"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListBucket",
        "s3:GetBucketLocation",
        "s3:ListBucketMultipartUploads",
        "s3:ListBucketVersions"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::${var.elasticsearch_snapshots_bucket_name}"
      ]
    },
    {
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:AbortMultipartUpload",
        "s3:ListMultipartUploadParts"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::${var.elasticsearch_snapshots_bucket_name}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "govuk_api_elasticsearch_snapshots_attachment" {
    name = "govuk_api_elasticsearch_snapshots_attachment_policy"
    users = ["${aws_iam_user.govuk_api_elasticsearch_snapshots_user.name}"]
    policy_arn = "${aws_iam_policy.govuk_api_elasticsearch_snapshots_policy.arn}"
}
