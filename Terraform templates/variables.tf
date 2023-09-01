
variable "statement" {
  description = "Defines the Sid statement, used in the assume role policy."
  default     = "assumedPolicy_advancedAWSidRole-2024"
}

variable "service" {
  description = "Defines the service which is referenced by the policy."
  default     = ["*"] # Replace with your desired service name.
}


variable "mode" {
  description = "Defines the name of the service."
  default     = ["*"] # Use a list here since you seem to want a list of strings
  type        = list(string) # Corrected type definition
}

variable "action" {
  description = "Defines the action of the role, according to the required performance on services."
  default     = true # Replace with your desired boolean value
  type        = bool
}

variable "effect" {
  description = "Defines whether the action is allowed or denied."
  default     = true # Replace with your desired boolean value
  type        = bool
}

variable "region" {
  description = "Defines the exact region, availability zone, and data center."
  type        = object({
    name = string
  })
  default = {
    name = "us-east-1" # Replace with your desired region name
  }
}

variable "account" {
  description = "Defines the account number, according to the IAM profile."
  default     = "093823058718" # Replace with your desired account number
}

variable "resource_type" {
  description = "Defines the resource type."
  default     = {
    name = "*"
  }
}

variable "resource_path" {
  description = "Defines the absolute path to each resource."
  default     = "/../../"
}

variable "continent" {
  description = "The continent in which the service resides."
  default     = "central" # Replace with your desired continent
}

variable "destination" {
  description = "The four destinations of a request."
  default     = "central" # Replace with your desired destination
}

variable "availability_zone_nr" {
  description = "One of three"
  default     = 2 # Replace with your desired number
  type        = number
}

variable "abc" {
  default = "c" # Replace with your desired string
  type    = string
}

variable "aws_account_id" {
  description = "AWS Account ID"
  type        = string
  default     = "093823058718"
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-central-1"
}
