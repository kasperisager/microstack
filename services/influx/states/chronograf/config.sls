/etc/systemd/system/chronograf.service:
  file.managed:
    - source: /tmp/config/chronograf/chronograf.service
  service.enabled:
    - name: chronograf

/etc/chronograf.d/config.toml:
  file.managed:
    - source: /tmp/config/chronograf/chronograf.toml
    - user: chronograf
    - group: chronograf
    - mode: 660

/etc/consul.d/chronograf.json:
  file.managed:
    - source: /tmp/config/chronograf/service.json
    - user: consul
    - group: consul
    - mode: 660
