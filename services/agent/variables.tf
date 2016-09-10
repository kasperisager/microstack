variable "servers" {
  type        = "string"
  description = "Number of agent servers to spin up."
}

variable "size" {
  type        = "string"
  description = "Size of the servers to spin up."
}

variable "region" {
  type        = "string"
  description = "Region in which to spin up the servers."
}

variable "image" {
  type        = "string"
  description = "Agent image ID returned by Packer when building the image."
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
