/tmp/chronograf/:
  archive.extracted:
    - source: https://dl.influxdata.com/chronograf/releases/chronograf-1.1.0~beta3_linux_amd64.tar.gz
    - source_hash: sha256=7654417646fb3eb1d17f888377ecd51a7ff1d4070d55276dabc646a0ec57375c
    - archive_format: tar

/opt/chronograf/bin/chronograf:
  file.managed:
    - source: /tmp/chronograf/chronograf-1.1.0~beta3-1/usr/bin/chronograf
    - user: chronograf
    - group: chronograf
    - mode: 750

/usr/bin/chronograf:
  file.symlink:
    - target: /opt/chronograf/bin/chronograf
    - user: chronograf
    - group: chronograf
    - mode: 750
