variable "vpc_cidr_block" {
  type = string
  default = null
  description = "Provide the VPC CIDR Range"
}

variable "public_subnet_zone1_cidr_block" {
  type = string
  default = null
  description = "Provide the public CIDR Range"
}

variable "public_subnet_zone2_cidr_block" {
  type = string
  default = null
  description = "Provide the public CIDR Range"
}

variable "private_subnet_zone1_cidr_block" {
  type = string
  default = null
  description = "Provide the private CIDR Range"
}

variable "private_subnet_zone2_cidr_block" {
  type = string
  default = null
  description = "Provide the private CIDR Range"
}

variable "eks_cpu_instance" {
  type = list(string)
  default = [ "null" ]
  description = "Provide the instance family"
}

variable "eks_version" {
  type = string
  default = null
  description = "Provide the private CIDR Range"
}