resource "digitalocean_droplet" "agent" {
  count  = "${var.servers}"
  image  = "${var.image}"
  region = "${var.region}"
  size   = "${var.size}"
  name   = "agent-${var.region}-${format("%02d", count.index + 1)}"

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
      "datacenter": "${self.region}",
      "bind_addr": "${self.ipv4_address}",
      "start_join": ${jsonencode(var.consul)}
    }
EOF
  }

  provisioner "file" {
    destination = "/etc/nomad.d/bootstrap.hcl"

    content = <<EOF
    name = "${self.name}"
    datacenter = "${self.region}"
    bind_addr = "${self.ipv4_address}"
    client {
      enabled = true
    }
EOF
  }
}
