# Region and aws key & secret start here.
variable "aws_region" {
  type        = string
  default     = "us-east-2"
  description = "The AWS region to deploy resources"
}

variable "access_key" {
  type        = string
  description = "The AWS secret key"
}

variable "secret_key" {
  type        = string
  sensitive   = true
  description = "The AWS secret key"
}
# VPC variables start here. 
variable "vpc_name" {
  description = "The name of the VPC"
  default     = "Techsecom_Cluster"
}

variable "private_subnets" {
  description = "The CIDR blocks for the private subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  description = "The CIDR blocks for the public subnets"
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "database_subnets" {
  description = "The CIDR blocks for the database subnets"
  default     = "10.0.128.0/19, 10.0.160.0/19"
}

# variable "Business_Divison" {
#   description = "value"
#   default     = null
# }

variable "aws_availability_zones" {
  description = "The list of availability zones"
  default     = ["us-east-2a, us-east-2b, us-east-2c"]
}

# variable "env" {
#   description = "value"
#   default     = null
# }

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

# variable "vpc_create_database_subnets" {
#   description = "value"
#   default     = null
# }

# variable "vpc_create_database_subnet_route_table" {
#   description = "value"
#   default     = null
# }

variable "vpc_enable_nat_gateway" {
  description = "value"
  default     = true
}

variable "vpc_single_nat_gateway" {
  description = "value"
  default     = true
}

# variable "github_token" {
#   type        = string
#   description = "value"
# }

variable "github_repo_name" {
  description = "value"
  default     = null
}
# OIDC variable 
variable "eks_oidc_root_ca_thumbprint" {
  type        = string
  description = "eks cluster root CA certificate"
  default     = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
}
# EKS variable start here
variable "cluster_name" {
  description = "Name of the EKS cluster. Also used as a prefix in names of related resources."
  default     = "Techsecom-eks-cluster"
}

# variable "cluster_service_ipv4_cidr" {
#   description = "service ipv4 cidr for the kubernetes cluster"
#   type        = string
#   default     = null
# }

# variable "cluster_version" {
#   description = "Kubernetes minor version to use for the EKS cluster (for example 1.21)"
#   type        = string
#   default     = null
# }
variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled. When it's set to `false` ensure to have a proper private access with `cluster_endpoint_private_access = true`."
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# variable "kelson_arn" {
#   description = "value"
#   default     = null
# }

# variable "kelson_name" {
#   description = "value"
#   default     = null
# }
# # EC2 instance for bastion start here
# variable "instance_type" {
#   description = "value"
#   default     = null
# }
# variable "ami" {
#     description = "value"
#     default = null
# }

# variable "connection-type" {
#     description = "value"
#     default = null
# }

# variable "connection-user" {
#     description = "value"
#     default = null
# }

variable "key_name" {
  type        = string
  description = "SSH key pair"
  default     = ""
}
