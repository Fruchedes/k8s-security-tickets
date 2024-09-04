data "aws_iam_policy_document" "eks_access_permission" {
  statement {
    sid = "EKSFullAccess"
    effect = "Allow"
    actions = [
      "eks:ListClusters",
      "eks:DescribeCluster",
      "eks:ListNodegroups",
      "eks:DescribeNodegroup",
      # Add more EKS actions as needed
    ]
    resources = ["*"]
  }
}