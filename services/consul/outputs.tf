output "addresses" {
  value = [
    "${digitalocean_floating_ip.consul.*.ip_address}",
  ]
}
