/etc/systemd/system/fabio.service:
  file.managed:
    - source: /tmp/config/fabio.service

/etc/fabio.d/config.properties:
  file.managed:
    - source: /tmp/config/fabio.properties
    - user: fabio
    - group: fabio
    - mode: 660
