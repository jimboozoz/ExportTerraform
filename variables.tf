#Variables

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "region" {
    description = "Default AWS region"
    default = "us-east-1"
}

variable "image" {
    description = "RedHat ami image"
    default =  "ami-011b3ccf1bd6db744"
}

variable "instance" {
    description = "Free Tier Instance"
    default =  "t2.micro"
}

variable "key" {
  description = "AWS Key"
  default = "virginiakey"
}
