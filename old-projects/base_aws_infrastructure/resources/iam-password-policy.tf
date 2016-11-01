resource "aws_iam_account_password_policy" "strict" {
  minimum_password_length = 12
  require_lowercase_characters = true
  require_numbers = true
  allow_users_to_change_password = true
}
