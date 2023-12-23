variable "aws_region" {
  type    = string
  default = "ap-south-1"
}


variable "availability_zones" {
  type    = list(string)
  default = (["ap-south-1a", "ap-south-1b"])
}

variable "environment" {
  type    = string
  default = "demoProject"
}

variable "vpc_id" {
  type    = string
  default = "vpc-031ccb5610c95bcf9"
}

variable "vpc_cidr_block" {
  type    = string
  default = "172.31.0.0/16"
}
variable "subnet_id_1" {
  type    = string
  default = "subnet-05cebd38dd8be8eb4"
}

variable "subnet_id_2" {
  type    = string
  default = "subnet-097132d797c9aef10"
}

variable "instance_ami" {
  type    = string
  default = "ami-03f4878755434977f"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "subnet_cidr_block_1" {
  type    = string
  default = "172.31.16.0/20"
}

variable "subnet_cidr_block_2" {
  type    = string
  default = "172.31.0.0/20"
}
