resource "digitalocean_droplet" "vault" {
  image    = "${var.image}"
  region   = "${var.region}"
  size     = "${var.size}"
  name     = "vault-${var.region}"
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
      "datacenter": "${var.region}",
      "bind_addr": "${self.ipv4_address_private}",
      "start_join": [
        ${join(",", formatlist("\"%s\"", var.consul_addresses))}
      ]
    }
EOF
    destination = "/etc/consul.d/bootstrap.json"
  }

  provisioner "remote-exec" {
    inline = [
      "systemctl restart consul firewall vault"
    ]
  }
}
