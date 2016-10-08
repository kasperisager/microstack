{% for service in "consul", "firewall" %}
/etc/systemd/system/{{service}}.service:
  file.managed:
    - source: /tmp/config/{{service}}.service

/etc/systemd/system/{{service}}.path:
  file.managed:
    - source: /tmp/config/{{service}}.path
  service.enabled:
    - name: {{service}}.path
{% endfor %}

/etc/consul.d/config.json:
  file.managed:
    - source: /tmp/config/consul.json
    - template: jinja
    - user: consul
    - group: consul

/etc/resolvconf/resolv.conf.d/head:
  file.append:
    - text: nameserver 127.0.0.1
