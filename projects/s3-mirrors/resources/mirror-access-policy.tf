data "aws_iam_policy_document" "s3_mirror_writer_policy_doc" {
  Statement {
    Sid = "S3SyncReadLists"
    Action = [
      "s3:GetBucketLocation",
      "s3:ListAllMyBuckets",
    ]
    Resource = "arn:aws:s3:::*"
  }

  Statement {
    Sid = "S3SyncReadWriteBucket"
    Action = ["s3:*"]
    Resource =  "arn:aws:s3:::${aws_s3_bucket.govuk_mirror.id}"
    principal {
      type = "AWS"
      identifiers = [
        "${aws_iam_role.s3_sync_user_role}"
      ]
    }
  }
}

resource "aws_iam_policy" "s3_mirror_writer_policy" {
  name = "s3_mirror_writer_policy_for_${aws_s3_bucket.govuk_mirror.name}"
  policy = "${data.aws_iam_policy_document.s3_mirror_writer_policy_doc.json}"
}

resource "aws_iam_user" "s3_mirror_writer_user" {
  name = "s3_mirror_writer"
}

resource "aws_iam_policy_attachment" "s3_mirror_writer_user_policy" {
  name = "s3_mirror_writer_user_policy_attachement"
  users = ["${aws_iam_user.s3_mirror_writer_user.name}"]
  policy_arn = "${aws_iam_policy.s3_mirror_writer_policy.arn}"
}
