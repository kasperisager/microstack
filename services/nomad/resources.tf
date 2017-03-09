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
      "salt-call -l quiet --local state.apply init.mount,init.persist",
    ]
  }

  provisioner "file" {
    destination = "/etc/consul.d/bootstrap.json"

    content = <<EOF
    {
      "node_name": "${self.name}",
      "datacenter": "${self.region}"
    }
EOF
  }

  provisioner "file" {
    destination = "/etc/nomad.d/bootstrap.hcl"

    content = <<EOF
    name = "${self.name}"
    datacenter = "${self.region}"
    data_dir = "/mnt/persist/nomad"
    server {
      enabled = true
      bootstrap_expect = ${self.count}
    }
EOF
  }

  provisioner "remote-exec" {
    inline = [
      "consul join ${join(" ", var.consul)}",
    ]
  }
}
