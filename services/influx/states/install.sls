/tmp/influx/:
  archive.extracted:
    - source: https://dl.influxdata.com/influxdb/releases/influxdb-1.0.2_linux_amd64.tar.gz
    - source_hash: sha256=269922c1341ae1d12013b2491ecb5503127833ffa1349729b842c75ca9916072
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
    - source: /tmp/influx/influxdb-1.0.2-1/usr/bin/{{file}}
    - user: influx
    - group: influx
    - mode: 750

/usr/bin/{{file}}:
  file.symlink:
    - target: /opt/influx/bin/{{file}}
    - user: influx
    - group: influx
    - mode: 750
{% endfor %}
