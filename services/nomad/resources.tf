resource "digitalocean_volume" "nomad" {
  count  = "${var.servers}"
  region = "${var.region}"
  size   = "${var.storage}"
  name   = "nomad-${var.region}-${format("%02d", count.index + 1)}"
}

resource "digitalocean_droplet" "nomad" {
  count  = "${var.servers}"
  image  = "${var.image}"
  region = "${var.region}"
  size   = "${var.size}"
  name   = "nomad-${var.region}-${format("%02d", count.index + 1)}"

  private_networking = true

  ssh_keys = [
    "${var.fingerprint}",
  ]

  volume_ids = [
    "${element(digitalocean_volume.nomad.*.id, count.index)}",
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

  provisioner "file" {
    destination = "/etc/nomad.d/server.hcl"

    content = <<EOF
    data_dir = "/mnt/persist/nomad"
    server {
      enabled = true
    }
EOF
  }

  provisioner "file" {
    destination = "/etc/nomad.d/bootstrap.hcl"

    content = <<EOF
    name = "${self.name}"
    datacenter = "${self.region}"
    bind_addr = "${self.ipv4_address_private}"
    server {
      bootstrap_expect = ${self.count}
    }
EOF
  }
}
