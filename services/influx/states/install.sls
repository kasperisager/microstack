/tmp/influx/:
  archive.extracted:
    - source: https://dl.influxdata.com/influxdb/releases/influxdb-1.0.0_linux_amd64.tar.gz
    - source_hash: sha256=de59bea4f97aa081d00afeffb080ce9ad90ada9ef80870c03760e7a5ed79c41b
    - archive_format: tar

{% for file in
  "influx",
  "influx_inspect",
  "influx_stress",
  "influx_tsm",
  "influxd"
%}
/opt/influx/bin/{{file}}:
  file.managed:
    - source: /tmp/influx/influxdb-1.0.0-1/usr/bin/{{file}}
    - user: influx
    - group: influx
    - mode: 770

/usr/bin/{{file}}:
  file.symlink:
    - target: /opt/influx/bin/{{file}}
    - user: influx
    - group: influx
    - mode: 770
{% endfor %}
