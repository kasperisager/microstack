/tmp/consul/:
  archive.extracted:
    - source: https://releases.hashicorp.com/consul/1.2.0/consul_1.2.0_linux_amd64.zip
    - source_hash: sha256=85d84ea3f6c68d52549a29b00fd0035f72c2eabff672ae46ca643cb407ef94b4
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
