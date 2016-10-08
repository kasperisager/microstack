/tmp/chronograf.deb:
  file.managed:
    - source: https://dl.influxdata.com/chronograf/releases/chronograf_1.0.0_amd64.deb
    - source_hash: sha256=7654417646fb3eb1d17f888377ecd51a7ff1d4070d55276dabc646a0ec57375c

dpkg -x /tmp/chronograf.deb /tmp/chronograf:
  cmd.run: []

/opt/chronograf/bin/chronograf:
  file.managed:
    - source: /tmp/chronograf/opt/chronograf/chronograf
    - user: chronograf
    - group: chronograf
    - mode: 770

/usr/bin/chronograf:
  file.symlink:
    - target: /opt/chronograf/bin/chronograf
    - user: chronograf
    - group: chronograf
    - mode: 770
