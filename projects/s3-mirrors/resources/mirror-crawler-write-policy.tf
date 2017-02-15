data "aws_iam_policy_document" "s3_mirror_crawler_writer_policy_doc" {
  statement {
    sid = "S3SyncReadLists"
    actions = [
      "s3:GetBucketLocation",
      "s3:ListAllMyBuckets",
    ]
    resources = [
      "arn:aws:s3:::*",
    ]
  }

  statement {
    sid = "S3SyncReadWriteBucket"
    actions = ["s3:*"]
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.govuk_mirror.id}",
    ]
  }
}

resource "aws_iam_policy" "s3_mirror_writer_policy" {
  name = "s3_mirror_writer_policy_for_${aws_s3_bucket.govuk_mirror.id}"
  policy = "${data.aws_iam_policy_document.s3_mirror_crawler_writer_policy_doc.json}"
}

resource "aws_iam_user" "s3_mirror_writer_user" {
  name = "s3_mirror_writer"
}

resource "aws_iam_policy_attachment" "s3_mirror_writer_user_policy" {
  name = "s3_mirror_writer_user_policy_attachement"
  users = ["${aws_iam_user.s3_mirror_writer_user.name}"]
  policy_arn = "${aws_iam_policy.s3_mirror_writer_policy.arn}"
}
