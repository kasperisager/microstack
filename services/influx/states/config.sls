/etc/systemd/system/influx.service:
  file.managed:
    - source: /tmp/config/influx.service

/etc/systemd/system/influx.path:
  file.managed:
    - source: /tmp/config/influx.path
  service.enabled:
    - name: influx.path

/etc/influx.d/config.toml:
  cmd.run:
    - name: /usr/bin/influxd config -config /tmp/config/influx.toml > /etc/influx.d/config.toml
  file.managed:
    - replace: false
    - user: influx
    - group: influx
    - mode: 660

/etc/consul.d/influxdb.json:
  file.managed:
    - source: /tmp/config/service.json
    - user: consul
    - group: consul
    - mode: 660
