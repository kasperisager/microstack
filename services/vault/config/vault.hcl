backend "consul" {
  tls_ca_file = "/etc/consul.d/ssl/ca.cert"
  tls_cert_file = "/etc/consul.d/ssl/consul.cert"
  tls_key_file = "/etc/consul.d/ssl/consul.key"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_cert_file = "/etc/vault.d/ssl/vault.cert"
  tls_key_file = "/etc/vault.d/ssl/vault.key"
}

telemetry {
  statsd_address = ":8125"
}
