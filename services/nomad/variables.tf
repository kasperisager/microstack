variable "servers" {
  type        = "string"
  default     = 3
  description = "Number of Nomad servers to spin up. Either 3 or 5 servers is recommended."
}

variable "size" {
  type        = "string"
  default     = "1gb"
  description = "Size of the servers to spin up. A minimum of 1gb is recommended."
}

variable "region" {
  type        = "string"
  description = "Region in which to spin up the servers."
}

variable "image" {
  type        = "string"
  description = "Nomad image ID returned by Packer when building the image."
}

variable "fingerprint" {
  type        = "string"
  description = "Fingerprint of the public SSH key to use for server authentication."
}

variable "private_key" {
  type        = "string"
  description = "Path to the private SSH key to use for server authentication."
}

variable "consul_addresses" {
  type        = "list"
  description = "List of Consul server addresses."
}
