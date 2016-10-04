variable "servers" {
  type        = "string"
  default     = 1
  description = "Number of Fabio servers to spin up."
}

variable "size" {
  type        = "string"
  default     = "1gb"
  description = "Size of the server to spin up. A minimum of 1gb is recommended."
}

variable "region" {
  type        = "string"
  description = "Region in which to spin up the server."
}

variable "image" {
  type        = "string"
  description = "Fabio image ID returned by Packer when building the image."
}

variable "fingerprint" {
  type        = "string"
  description = "Fingerprint of the public SSH key to use for server authentication."
}

variable "private_key" {
  type        = "string"
  description = "Private SSH key to use for server authentication."
}

variable "consul" {
  type        = "list"
  description = "List of Consul server addresses."
}
