/tmp/consul/:
  archive.extracted:
    - source: https://releases.hashicorp.com/consul/0.8.0/consul_0.8.0_linux_amd64.zip
    - source_hash: sha256=f4051c2cab9220be3c0ca22054ee4233f1396c7138ffd97a38ffbcea44377f47
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
