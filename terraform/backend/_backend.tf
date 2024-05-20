terraform {
  backend "s3" {
    region         = "eu-west-1"
    bucket         = "tf-awsuglisbon-1397-state"
    key            = "awsuglisbon.backend.tfstate"
    dynamodb_table = "tf-awsuglisbon-1397-locktable"
    encrypt        = true
    profile        = "tig-awsug"
  }
}
