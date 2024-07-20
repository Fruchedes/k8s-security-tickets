

terraform {

  backend "s3" {
    bucket         = "techsecom-terraform-users-state"
    key            = "techsecom-users.tfstate"
    region         = "us-east-2"
    dynamodb_table = "techsecom-db-terraform-users-state"
    encrypt        = true
  }
}