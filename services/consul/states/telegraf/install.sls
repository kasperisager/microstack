/tmp/telegraf/:
  archive.extracted:
    - source: https://dl.influxdata.com/telegraf/releases/telegraf-1.1.0_linux_amd64.tar.gz
    - source_hash: sha256=b2f59898df2caabc801dd23f1e0fc7edc7d511550710dc7f72ecd7f12c9c4c37
    - archive_format: tar

/opt/telegraf/bin/telegraf:
  file.managed:
    - source: /tmp/telegraf/telegraf/usr/bin/telegraf
    - user: telegraf
    - group: telegraf
    - mode: 750

/usr/bin/telegraf:
  file.symlink:
    - target: /opt/telegraf/bin/telegraf
    - user: telegraf
    - group: telegraf
    - mode: 750
