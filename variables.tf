# bucket variable
variable "bucket_name" {
  type        = string
  description = "bucket for aws project 2"
}

#VPC variables
variable "aws_vpc_project_2" {
  description = "default vpc cidr block"
  type        = string
  default     = "172.16.0.0/16"
}


# region variable
variable "region" {
  type = string
  description = "region of workplace"
}

# route 53 variable  
variable "domain_name" {

  default = "devops-yvesb.cf"
  type = string 
  description = "domain name"

}

# dns record 
variable "record_name" {

  default = "devopslearning"
  description = "sub domain name"
  type = string

}

variable "fqdn" {
  type = string
  
}