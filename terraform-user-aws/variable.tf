
# variable "user_name" {
#     type = list
#     default = [
#         "paddy-Bissong"
#     ]
# }
variable "user_names" {
  description = "List of IAM usernames to create"
  type        = list(string)
}