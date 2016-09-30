resource "digitalocean_droplet" "fabio" {
  image    = "${var.image}"
  region   = "${var.region}"
  size     = "${var.size}"
  name     = "fabio-${var.region}"
  ssh_keys = [
    "${var.fingerprint}"
  ]
  private_networking = true

  connection {
    type        = "ssh"
    private_key = "${trimspace(file("${var.private_key}"))}"
  }

  provisioner "file" {
    content = <<EOF
    {
      "node_name": "${self.name}",
      "datacenter": "${self.region}",
      "bind_addr": "${self.ipv4_address_private}",
      "start_join": ${jsonencode(var.consul)}
    }
EOF
    destination = "/etc/consul.d/bootstrap.json"
  }
}
