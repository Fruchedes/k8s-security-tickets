output "user_passwords" {

  value = { for username, profile in aws_iam_user_login_profile.example : username => profile.password }
}
# output "password" {
#   value = aws_iam_user_login_profile.example.password
# }
