output "fingerprint" {
  value = "${digitalocean_ssh_key.microstack.fingerprint}"
}

output "public" {
  value = "${trimspace(file("${var.public_key}"))}"
}

output "private" {
  sensitive = true
  value     = "${trimspace(file("${var.private_key}"))}"
}
