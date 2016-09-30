resource "digitalocean_droplet" "nomad" {
  count    = "${var.servers}"
  image    = "${var.image}"
  region   = "${var.region}"
  size     = "${var.size}"
  name     = "nomad-${var.region}-${format("%02d", count.index + 1)}"
  ssh_keys = [
    "${var.fingerprint}"
  ]
  private_networking = true

  connection {
    type        = "ssh"
    private_key = "${var.private_key}"
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

  provisioner "file" {
    content = <<EOF
    name = "${self.name}"
    datacenter = "${self.region}"
    bind_addr = "${self.ipv4_address_private}"
    server {
      enabled = true
      bootstrap_expect = ${self.count}
    }
EOF
    destination = "/etc/nomad.d/bootstrap.hcl"
  }
}
