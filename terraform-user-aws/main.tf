
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

resource "aws_iam_role" "eks_cluster_role" {
  for_each    = aws_iam_user.example
  name = "eks-cluster-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  for_each    = aws_iam_user.example
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks_service_policy" {
  for_each    = aws_iam_user.example
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster_role.name
}
# arn:aws:iam::905418274520:user/prince split("-", "iam-ChangePassword-for-prince")[3]
