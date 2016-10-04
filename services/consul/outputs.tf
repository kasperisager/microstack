output "addresses" {
  value = [
    "${digitalocean_droplet.consul.*.ipv4_address_private}",
  ]
}
