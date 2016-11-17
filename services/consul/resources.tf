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
      "salt-call --local state.apply init.mount,init.persist",
    ]
  }

  provisioner "file" {
    destination = "/etc/consul.d/server.json"

    content = <<EOF
    {
      "data_dir": "/mnt/persist/consul",
      "server": true,
      "ui": true,
      "node_name": "${self.name}",
      "datacenter": "${self.region}"
    }
EOF
  }
}

resource "digitalocean_floating_ip" "consul" {
  count      = "${var.servers}"
  region     = "${var.region}"
  droplet_id = "${element(digitalocean_droplet.consul.*.id, count.index)}"
}

resource "null_resource" "consul" {
  count = "${var.servers}"

  triggers {
    consul_ids = "${jsonencode(digitalocean_droplet.consul.*.id)}"
  }

  connection {
    type        = "ssh"
    host        = "${element(digitalocean_droplet.consul.*.ipv4_address, count.index)}"
    private_key = "${var.private_key}"
  }

  provisioner "file" {
    destination = "/etc/consul.d/bootstrap.json"

    content = <<EOF
    {
      "bootstrap_expect": ${self.count},
      "advertise_addr": "${element(digitalocean_floating_ip.consul.*.ip_address, count.index)}",
      "start_join": ${jsonencode(digitalocean_floating_ip.consul.*.ip_address)}
    }
EOF
  }
}
