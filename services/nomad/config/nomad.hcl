data_dir = "/var/nomad"
leave_on_interrupt = true
leave_on_terminate = true

server {
  encrypt = "{{salt.random.str_encode(salt.random.get_str(16)) | trim}}"
}

client {
  options = {
    "driver.whitelist" = "docker,rkt"
  }
}

telemetry {
  statsd_address = ":8125"
  disable_hostname = true
}

tls {
  http = true
  rpc = true
  ca_file = "/etc/microstack.d/ssl/ca.crt"
  cert_file = "/etc/nomad.d/ssl/nomad.crt"
  key_file = "/etc/nomad.d/ssl/nomad.key"
}
