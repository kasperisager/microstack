resource "digitalocean_volume" "influx" {
  count  = "${var.servers}"
  region = "${var.region}"
  size   = "${var.storage}"
  name   = "influx-${var.region}-${format("%02d", count.index + 1)}"
}

resource "digitalocean_droplet" "influx" {
  count  = "${var.servers}"
  image  = "${var.image}"
  region = "${var.region}"
  size   = "${var.size}"
  name   = "influx-${var.region}-${format("%02d", count.index + 1)}"

  ssh_keys = [
    "${var.fingerprint}",
  ]

  volume_ids = [
    "${element(digitalocean_volume.influx.*.id, count.index)}",
  ]

  connection {
    type        = "ssh"
    private_key = "${var.private_key}"
  }

  provisioner "remote-exec" {
    inline = [
      "salt-call -l quiet --local state.apply init.mount,init.persist",
    ]
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
}
