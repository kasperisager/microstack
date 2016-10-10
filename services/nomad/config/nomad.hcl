data_dir = "/var/nomad"
leave_on_terminate = true
client {
  options = {
    "driver.whitelist" = "docker,rkt"
  }
}
telemetry {
  statsd_address = ":8125"
  disable_hostname = true
}
