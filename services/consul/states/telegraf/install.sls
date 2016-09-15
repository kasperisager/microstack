/tmp/telegraf/:
  archive.extracted:
    - source: https://dl.influxdata.com/telegraf/releases/telegraf-1.0.0_linux_amd64.tar.gz
    - source_hash: sha256=f6ba7d4a0b76b069824166a4fd04900f86fc4fa6115a4c11084566670b4f6bf0
    - archive_format: tar

/opt/telegraf/bin/telegraf:
  file.managed:
    - source: /tmp/telegraf/telegraf/usr/bin/telegraf
    - user: telegraf
    - group: telegraf
    - mode: 770

/usr/bin/telegraf:
  file.symlink:
    - target: /opt/telegraf/bin/telegraf
    - user: telegraf
    - group: telegraf
    - mode: 770
