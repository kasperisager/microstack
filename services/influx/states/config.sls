/etc/systemd/system/influx.service:
  file.managed:
    - source: /tmp/config/influx.service
  service.enabled:
    - name: influx

/etc/influx.d/config.conf:
  cmd.run:
    - name: /usr/bin/influxd config -config /tmp/config/influx.conf > /etc/influx.d/config.conf
  file.managed:
    - replace: false
    - user: influx
    - group: influx

/etc/consul.d/influxdb.json:
  file.managed:
    - source: /tmp/config/service.json
    - user: consul
    - group: consul
