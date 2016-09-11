/tmp/consul/:
  archive.extracted:
    - source: https://releases.hashicorp.com/consul/0.6.4/consul_0.6.4_linux_amd64.zip
    - source_hash: sha256=abdf0e1856292468e2c9971420d73b805e93888e006c76324ae39416edcf0627
    - archive_format: zip

/opt/consul/bin/consul:
  file.managed:
    - source: /tmp/consul/consul
    - user: consul
    - group: consul
    - mode: 770

/opt/consul/bin/firewall:
  file.managed:
    - source: /tmp/config/firewall
    - user: consul
    - group: consul
    - mode: 770

{% for file in "consul", "firewall" %}
/usr/bin/{{file}}:
  file.symlink:
    - target: /opt/consul/bin/{{file}}
    - user: consul
    - group: consul
    - mode: 770
{% endfor %}
