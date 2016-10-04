resource "digitalocean_droplet" "influx" {
  image  = "${var.image}"
  region = "${var.region}"
  size   = "${var.size}"
  name   = "influx-${var.region}"

  ssh_keys = [
    "${var.fingerprint}",
  ]

  private_networking = true

  connection {
    type        = "ssh"
    private_key = "${var.private_key}"
  }

  provisioner "file" {
    destination = "/etc/consul.d/bootstrap.json"

    content = <<EOF
    {
      "node_name": "${self.name}",
      "datacenter": "${self.region}",
      "bind_addr": "${self.ipv4_address_private}",
      "start_join": ${jsonencode(var.consul)}
    }
EOF
  }
}
