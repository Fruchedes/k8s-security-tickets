# create users
data "aws_ssoadmin_instances" "this" {}

#create users
resource "aws_identitystore_user" "this" {
  for_each = var.users

  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]

  display_name = "${each.value.given_name} ${each.value.family_name}"
  user_name    = each.value.email

  name {
    given_name  = each.value.given_name
    family_name = each.value.family_name
  }

  emails {
    value = each.value.email
  }
}

# creates the group
resource "aws_identitystore_group" "this" {
  for_each = var.groups

  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  display_name      = each.value.group_name
  description       = each.value.description
}

# creates the group membership
resource "aws_identitystore_group_membership" "this" {
  for_each = tomap({
    for group_membership in local.group_memberships : "${group_membership.user_key}.${group_membership.group_key}" => group_membership
  })

  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  group_id          = aws_identitystore_group.this[each.value.group_key].group_id
  member_id         = aws_identitystore_user.this[each.value.user_key].user_id
}

#create permission set
resource "aws_ssoadmin_permission_set" "this" {
  for_each = var.groups
  name             = each.value.permission_set_name
  description      = each.value.description
  instance_arn     = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  session_duration = each.value.permission_set_session_duration
}

#create inline policy
resource "aws_ssoadmin_permission_set_inline_policy" "this" {
  for_each = local.permission_set_inline_policies

  inline_policy      = data.aws_iam_policy_document.eks_access_permission.json
  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.this[each.key].arn
}

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

#creates the account assignement
resource "aws_ssoadmin_account_assignment" "this" {
  for_each = tomap({
    for account_assignment in local.account_assignements : "${account_assignment.account_key}.${account_assignment.group_key}" => account_assignment
  })

  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.this[each.value.group_key].arn

  principal_id   = aws_identitystore_group.this[each.value.group_key].group_id
  principal_type = "GROUP"

  target_id   = "905418274520"
  target_type = "AWS_ACCOUNT"
}
/*
resource "aws_ssoadmin_managed_policy_attachment" "this" {
  for_each = tomap({
    for managed_policy_attachment in local.managed_policy_attachments : "${managed_policy_attachment.group_key}.${managed_policy_attachment.managed_policy_arn}" => managed_policy_attachment
  })

  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  managed_policy_arn = each.value.managed_policy_arn
  permission_set_arn = aws_ssoadmin_permission_set.this[each.value.group_key].arn
}
*/