variable "aws_access_key" {
  description = "The AWS access key"
  type        = string
  default     = ""
}

variable "aws_secret_key" {
  description = "The AWS secret key"
  type        = string
  default     = ""
}

variable "token" {
  description = "The AWS token"
  type        = string
  default     = ""
}
variable "aws_region" {
  description = "The AWS region to create Users"
  type        = string
  default     = ""
}

variable "users" {
  type = map(object({
    given_name  = string 
    family_name = string
    email       = string
    groups      = list(string)
  }))
  default = {
    "Harold_Morrel" = {
      given_name = "Harold"
      family_name = "Morrel"
      email = "harold.morrel@techsecoms.com"
      groups = [
        "Techsecom_Engineers"
      ]
    }
    "Paddy_nfortabi" = {
      given_name = "Paddy"
      family_name = "nfortabi"
      email = "paddy.nfortabi@techsecoms.com"
      groups = [
        "Techsecom_Engineers"
      ]
    }
    "Taiwo_Oladeri" = {
      given_name = "Taiwo"
      family_name = "Oladeri"
      email = "taiwo.oladeru@techsecoms.com"
      groups = [
        "Techsecom_Engineers"
      ]
    }
    "Kelson_Kanu" = {
      given_name = "Kelson"
      family_name = "Kanu"
      email = "kelson.kanu@techsecoms.com"
      groups = [
        "Techsecom_Engineers"
      ]
    }
  }
}

variable "groups" {
  type = map(object({
    group_name                      = string
    permission_set_name             = string
    description                     = string
    permission_set_session_duration = string
    inline_policy                   = optional(string)
    managed_policy_arns             = optional(list(string), [])
  }))

  default = {
    "Techsecom_Engineers" = {
      group_name = "Techsecom_Engineers"
      permission_set_name = "eks_access_perm"  # Replace with actual permission set name
      description = "eks_access_perm"
      permission_set_session_duration = "PT12H"  # Adjust as needed
      #inline_policy = data.aws_iam_policy_document.eks_policy.json
      # Optional: managed_policy_arns = ["arn:aws:iam::123456789012:policy/ReadOnlyAccess"]
    }
  }
}

variable "accounts" {
  type = map(object({
    account_number = string
    groups         = list(string)
    is_management  = optional(bool, false)
  }))
  default = {
    "905418274520" = {
      account_number = "905418274520"
      groups = ["Techsecom_Engineers"]
      is_management = false
    }
  }
}
