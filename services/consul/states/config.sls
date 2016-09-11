/etc/systemd/system/consul.service:
  file.managed:
    - source: /tmp/config/consul.service

/etc/systemd/system/firewall.service:
  file.managed:
    - source: /tmp/config/firewall.service

/etc/consul.d/config.json:
  file.managed:
    - source: /tmp/config/consul.json
    - template: jinja
    - user: consul
    - group: consul

/etc/resolvconf/resolv.conf.d/head:
  file.append:
    - text: nameserver 127.0.0.1
