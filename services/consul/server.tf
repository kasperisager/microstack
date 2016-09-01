resource "random_id" "encryption_key" {
  byte_length = 8
}

resource "digitalocean_droplet" "consul" {
  count    = "${var.servers}"
  image    = "${var.image}"
  region   = "${var.region}"
  size     = "${var.size}"
  name     = "consul-${var.region}-${format("%02d", count.index + 1)}"
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
      "server": true,
      "ui": true,
      "bind_addr": "${self.ipv4_address_private}",
      "bootstrap_expect": ${var.servers},
      "encrypt": "${base64encode(random_id.encryption_key.hex)}",
      "start_join": [
        "${digitalocean_droplet.consul.0.ipv4_address_private}"
      ]
    }
EOF
    destination = "/etc/consul.d/bootstrap.json"
  }

  provisioner "remote-exec" {
    inline = [
      "systemctl restart consul.service"
    ]
  }
}

output "addresses" {
  value = [
    "${digitalocean_droplet.consul.*.ipv4_address_private}"
  ]
}

output "encryption_key" {
  sensitive = true
  value     = "${base64encode(random_id.encryption_key.hex)}"
}
