{% for service in "consul", "firewall" %}
/etc/systemd/system/{{service}}.service:
  file.managed:
    - source: /tmp/config/{{service}}.service
{% endfor %}

/etc/systemd/system/consul.path:
  file.managed:
    - source: /tmp/config/consul.path
  service.enabled:
    - name: consul.path

/etc/consul.d/config.json:
  file.managed:
    - source: /tmp/config/consul.json
    - template: jinja
    - user: consul
    - group: consul

/etc/resolvconf/resolv.conf.d/head:
  file.append:
    - text: nameserver 127.0.0.1
