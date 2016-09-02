/etc/systemd/system/consul.service:
  file.managed:
    - source: /tmp/config/consul.service

/etc/consul.d/config.json:
  file.managed:
    - source: /tmp/config/consul.json
    - template: jinja
    - user: consul
    - group: consul
