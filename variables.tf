variable "location" {
  description = "Azure location"
  default     = "West Europe"
}

variable "failover_location" {
  description = "Azure location"
  default     = "North Europe"
}

variable "G4L_HDI_GW_USERNAME" {
  type = string
}
variable "G4L_HDI_GW_PASSWORD" {
  type = string
}
variable "G4L_HDI_R_HN_USERNAME" {
  type = string
}
variable "G4L_HDI_R_HN_PASSWORD" {
  type = string
}
variable "G4L_HDI_R_WN_USERNAME" {
  type = string
}
variable "G4L_HDI_R_WN_PASSWORD" {
  type = string
}
variable "G4L_HDI_R_ZN_USERNAME" {
  type = string
}
variable "G4L_HDI_R_ZN_PASSWORD" {
  type = string
}

# variable "instance_type" {
#   description = "Type of EC2 instance to provision"
#   default     = "t2.micro"
# }

# variable "instance_name" {
#   description = "EC2 instance name"
#   default     = "Provisioned by Terraform"
# }
