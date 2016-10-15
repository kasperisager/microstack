provider "digitalocean" {
  token = "${var.token}"
}

module "keypair" {
  source = "common/keypair"
}

module "consul" {
  source      = "services/consul"
  region      = "${var.region}"
  image       = "${var.images["consul"]}"
  size        = "${var.sizes["consul"]}"
  servers     = "${var.servers["consul"]}"
  fingerprint = "${module.keypair.fingerprint}"
  private_key = "${module.keypair.private}"
}

module "influx" {
  source      = "services/influx"
  region      = "${var.region}"
  image       = "${var.images["influx"]}"
  size        = "${var.sizes["influx"]}"
  servers     = "${var.servers["influx"]}"
  fingerprint = "${module.keypair.fingerprint}"
  private_key = "${module.keypair.private}"
  consul      = "${module.consul.addresses}"
}

module "vault" {
  source      = "services/vault"
  region      = "${var.region}"
  image       = "${var.images["vault"]}"
  size        = "${var.sizes["vault"]}"
  servers     = "${var.servers["vault"]}"
  fingerprint = "${module.keypair.fingerprint}"
  private_key = "${module.keypair.private}"
  consul      = "${module.consul.addresses}"
}

module "nomad" {
  source      = "services/nomad"
  region      = "${var.region}"
  image       = "${var.images["nomad"]}"
  size        = "${var.sizes["nomad"]}"
  servers     = "${var.servers["nomad"]}"
  fingerprint = "${module.keypair.fingerprint}"
  private_key = "${module.keypair.private}"
  consul      = "${module.consul.addresses}"
}

module "agent" {
  source      = "services/agent"
  region      = "${var.region}"
  image       = "${var.images["agent"]}"
  size        = "${var.sizes["agent"]}"
  servers     = "${var.servers["agent"]}"
  fingerprint = "${module.keypair.fingerprint}"
  private_key = "${module.keypair.private}"
  consul      = "${module.consul.addresses}"
}

module "fabio" {
  source      = "services/fabio"
  region      = "${var.region}"
  image       = "${var.images["fabio"]}"
  size        = "${var.sizes["fabio"]}"
  servers     = "${var.servers["fabio"]}"
  fingerprint = "${module.keypair.fingerprint}"
  private_key = "${module.keypair.private}"
  consul      = "${module.consul.addresses}"
}
