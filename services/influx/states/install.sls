/tmp/influx/:
  archive.extracted:
    - source: https://dl.influxdata.com/influxdb/releases/influxdb-1.1.1_linux_amd64.tar.gz
    - source_hash: sha256=fe6094788d6c33461e274527639fdf13013d4122a4f194285f2e3b86495385cc
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
    - source: /tmp/influx/influxdb-1.1.1-1/usr/bin/{{file}}
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
