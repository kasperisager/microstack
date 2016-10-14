/tmp/consul/:
  archive.extracted:
    - source: https://releases.hashicorp.com/consul/0.7.0/consul_0.7.0_linux_amd64.zip
    - source_hash: sha256=b350591af10d7d23514ebaa0565638539900cdb3aaa048f077217c4c46653dd8
    - archive_format: zip

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
