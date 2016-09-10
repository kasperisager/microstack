/etc/systemd/system/consul.service:
  file.managed:
    - source: /tmp/config/consul.service
  service.enabled:
    - name: consul

/etc/systemd/system/firewall.service:
  file.managed:
    - source: /tmp/config/firewall.service
  service.enabled:
    - name: firewall

/etc/consul.d/config.json:
  file.managed:
    - source: /tmp/config/consul.json
    - template: jinja
    - user: consul
    - group: consul
