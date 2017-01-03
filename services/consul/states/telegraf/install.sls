/tmp/telegraf/:
  archive.extracted:
    - source: https://dl.influxdata.com/telegraf/releases/telegraf-1.1.2_linux_amd64.tar.gz
    - source_hash: sha256=5494acc5f72548f3c8f9e053a278e11b5fc6ab1f6bee2d5fea305fbe63c46ae6
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
