variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "rest_api_name" {
  description = "Rest API name"
  type        = string
}

# variable "rest_api_path" {
#   description = "Rest API Path"
#   type        = string
# }

variable "stage_name" {
  description = "Deployment stage name"
  type        = string
  default     = "dev"
}
