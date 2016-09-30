resource "digitalocean_ssh_key" "microstack" {
  name = "microstack-${uuid()}"
  public_key = "${trimspace(file("${var.public_key}"))}"

  lifecycle {
    ignore_changes = [
      "name"
    ]
  }
}

output "fingerprint" {
  value = "${digitalocean_ssh_key.microstack.fingerprint}"
}

output "public" {
  value = "${trimspace(file("${var.public_key}"))}"
}

output "private" {
  sensitive = true
  value = "${trimspace(file("${var.private_key}"))}"
}
