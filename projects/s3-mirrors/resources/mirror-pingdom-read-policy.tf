
data "external" "pingdom" {
  program = ["/bin/bash", "${path.module}/pingdom_probe_ips.sh"]
}

data "aws_iam_policy_document" "s3_mirror_pingdom_read_policy_doc" {
  statement {
    sid = "S3PingdomReadBucket"
    actions = ["s3:GetObject"]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.govuk_mirror.id}",
      "arn:aws:s3:::${aws_s3_bucket.govuk_mirror.id}/*",
    ]
    condition {
      test = "IpAddress"
      variable = "aws:SourceIp"
      values = ["${split(",",data.external.pingdom.result.pingdom_probe_ips)}"]
    }

    # Apparently bucket policies must have a principal
    principals {
      type = "AWS"
      identifiers = ["*"]
    }
  }
}
