
data "aws_caller_identity" "current" {}

resource "aws_iam_user" "example" {
  for_each = toset(var.user_names)

  name          = each.value
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "example" {
  for_each                = aws_iam_user.example
  user                    = each.value.name
  password_reset_required = true
  password_length         = 10
}

resource "aws_iam_policy" "policy" {
  for_each    = aws_iam_user.example
  name        = "iam-ChangePassword-for-${each.value.name}"
  description = "Allow ${each.value.name} to change password"
  policy      = <<-EOT
        {
            "Version": "2012-10-17",
            "Statement": [
                {
                    "Effect": "Allow",
                    "Action": "iam:ChangePassword",
                    "Resource": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${each.value.name}"
                }
            ]
        }
    EOT
  #policy      = "{ ... policy JSON ... }"
}

resource "aws_iam_user_policy_attachment" "test-attach" {
    for_each =  aws_iam_policy.policy
  user       = split("-", "${each.value.name}")[3]
  policy_arn = each.value.arn
}

# arn:aws:iam::905418274520:user/prince split("-", "iam-ChangePassword-for-prince")[3]
