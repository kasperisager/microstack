variable "token" {
  type        = "string"
  description = "DigitalOcean personal access token."
}

variable "region" {
  type        = "string"
  description = "The region in which to spin up the infrastructure."
}

variable "sizes" {
  type        = "map"
  default     = {}
  description = "Map of server sizes for the different services."
}

variable "servers" {
  type        = "map"
  default     = {}
  description = "Map of server counts for the different services."
}

variable "images" {
  type        = "map"
  default     = {}
  description = "Map of image IDs for the different services."
}
