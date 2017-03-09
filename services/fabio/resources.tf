resource "digitalocean_droplet" "fabio" {
  count  = "${var.servers}"
  image  = "${var.image}"
  region = "${var.region}"
  size   = "${var.size}"
  name   = "fabio-${var.region}-${format("%02d", count.index + 1)}"

  ssh_keys = [
    "${var.fingerprint}",
  ]

  connection {
    type        = "ssh"
    private_key = "${var.private_key}"
  }

  provisioner "file" {
    destination = "/etc/consul.d/bootstrap.json"

    content = <<EOF
    {
      "node_name": "${self.name}",
      "datacenter": "${self.region}"
    }
EOF
  }

  provisioner "remote-exec" {
    inline = [
      "consul join ${join(" ", var.consul)}",
    ]
  }
}
