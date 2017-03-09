/tmp/consul/:
  archive.extracted:
    - source: https://releases.hashicorp.com/consul/0.7.1/consul_0.7.1_linux_amd64.zip
    - source_hash: sha256=5dbfc555352bded8a39c7a8bf28b5d7cf47dec493bc0496e21603c84dfe41b4b
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
