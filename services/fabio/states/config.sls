/etc/systemd/system/fabio.service:
  file.managed:
    - source: /tmp/config/fabio.service

/etc/systemd/system/fabio.path:
  file.managed:
    - source: /tmp/config/fabio.path
  service.enabled:
    - name: fabio.path

/etc/fabio.d/config.properties:
  file.managed:
    - source: /tmp/config/fabio.properties
    - user: fabio
    - group: fabio
    - mode: 660
