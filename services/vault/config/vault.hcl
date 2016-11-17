backend "consul" {
  tls_ca_file = "/etc/microstack.d/ssl/ca.crt"
  tls_cert_file = "/etc/consul.d/ssl/consul.crt"
  tls_key_file = "/etc/consul.d/ssl/consul.key"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_cert_file = "/etc/vault.d/ssl/vault.crt"
  tls_key_file = "/etc/vault.d/ssl/vault.key"
}

telemetry {
  statsd_address = ":8125"
  disable_hostname = true
}
