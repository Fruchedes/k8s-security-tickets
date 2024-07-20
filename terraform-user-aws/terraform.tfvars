user_names = ["kelson", "paddy", "Mccoy", "Teebaba", "harold", "prince", "peter", "solomom", "Edwin"] # Add more usernames as needed

# resource "aws_iam_user" "example" {

#   #   count = length(var.user_name )
#   #   name          = count.index[var.user_name] 
#   name          = "paddy-Bissong" 
#   path          = "/"
#   force_destroy = true
# }

# resource "aws_iam_user_login_profile" "example" {
#   user                    = aws_iam_user.example.name
#   password_reset_required = true
#   password_length         = 10
# }

# variable "user_name" {
#     type = list
#     default = [
#         "paddy-Bissong"
#     ]
# }