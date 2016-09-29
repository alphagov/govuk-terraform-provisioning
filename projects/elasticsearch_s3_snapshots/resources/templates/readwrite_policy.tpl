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
        "arn:aws:s3:::${bucket_name}-api-elasticserach-${environment}",
        "arn:aws:s3:::${bucket_name}-logs-elasticsearch-${environment}"
      ]
    },
    {
      "Action": [
        "s3:GetObject",
        "s3:GetObjectACL",
        "s3:PutObject",
        "s3:PutObjectACL",
        "S3:DeleteObject",
        "s3:AbortMultipartUpload",
        "s3:ListMultipartUploadParts"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::${bucket_name}-api-elasticserach-${environment}/*",
        "arn:aws:s3:::${bucket_name}-logs-elasticsearch-${environment}/*"
      ]
    }
  ]
}
