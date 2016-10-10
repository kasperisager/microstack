resource "digitalocean_volume" "consul" {
  count  = "${var.servers}"
  region = "${var.region}"
  size   = "${var.storage}"
  name   = "consul-${var.region}-${format("%02d", count.index + 1)}"
}

resource "digitalocean_droplet" "consul" {
  count  = "${var.servers}"
  image  = "${var.image}"
  region = "${var.region}"
  size   = "${var.size}"
  name   = "consul-${var.region}-${format("%02d", count.index + 1)}"

  private_networking = true

  ssh_keys = [
    "${var.fingerprint}",
  ]

  volume_ids = [
    "${element(digitalocean_volume.consul.*.id, count.index)}",
  ]

  connection {
    type        = "ssh"
    private_key = "${var.private_key}"
  }

  provisioner "remote-exec" {
    inline = [
      "salt-call --local state.apply init.volume",
    ]
  }

  provisioner "file" {
    destination = "/etc/consul.d/server.json"

    content = <<EOF
    {
      "data_dir": "/mnt/persist/consul",
      "server": true,
      "ui": true
    }
EOF
  }

  provisioner "file" {
    destination = "/etc/consul.d/bootstrap.json"

    content = <<EOF
    {
      "node_name": "${self.name}",
      "datacenter": "${self.region}",
      "bind_addr": "${self.ipv4_address_private}",
      "bootstrap_expect": ${self.count},
      "start_join": [
        "${digitalocean_droplet.consul.0.ipv4_address_private}"
      ]
    }
EOF
  }
}
