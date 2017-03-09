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
      "salt-call -l quiet --local state.apply init.mount,init.persist",
    ]
  }

  provisioner "file" {
    destination = "/etc/consul.d/bootstrap.json"

    content = <<EOF
    {
      "node_name": "${self.name}",
      "datacenter": "${self.region}",
      "bootstrap_expect": ${self.count},
      "data_dir": "/mnt/persist/consul",
      "server": true,
      "ui": true
    }
EOF
  }

  provisioner "remote-exec" {
    inline = [
      "consul join ${digitalocean_droplet.consul.0.ipv4_address}",
    ]
  }
}
