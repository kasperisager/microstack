/tmp/consul/:
  archive.extracted:
    - source: https://releases.hashicorp.com/consul/0.7.5/consul_0.7.5_linux_amd64.zip
    - source_hash: sha256=40ce7175535551882ecdff21fdd276cef6eaab96be8a8260e0599fadb6f1f5b8
    - archive_format: zip
    - enforce_toplevel: false

/opt/consul/bin/consul:
  file.managed:
    - source: /tmp/consul/consul
    - user: consul
    - group: consul
    - mode: 750

/opt/consul/bin/firewall:
  file.managed:
    - source: /tmp/config/firewall
    - user: consul
    - group: consul
    - mode: 750

{% for file in "consul", "firewall" %}
/usr/bin/{{file}}:
  file.symlink:
    - target: /opt/consul/bin/{{file}}
    - user: consul
    - group: consul
    - mode: 750
{% endfor %}
