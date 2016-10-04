resource "digitalocean_ssh_key" "microstack" {
  name       = "microstack-${uuid()}"
  public_key = "${trimspace(file("${var.public_key}"))}"

  lifecycle {
    ignore_changes = [
      "name",
    ]
  }
}
