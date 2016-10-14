/etc/systemd/system/telegraf.service:
  file.managed:
    - source: /tmp/config/telegraf/telegraf.service

/etc/systemd/system/telegraf.path:
  file.managed:
    - source: /tmp/config/telegraf/telegraf.path
  service.enabled:
    - name: telegraf.path

/etc/telegraf.d/config.toml:
  file.managed:
    - source: /tmp/config/telegraf/telegraf.toml
    - user: telegraf
    - group: telegraf
    - mode: 640
