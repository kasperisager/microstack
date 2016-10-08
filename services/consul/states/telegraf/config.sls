/etc/systemd/system/telegraf.service:
  file.managed:
    - source: /tmp/config/telegraf/telegraf.service
  service.enabled:
    - name: telegraf

/etc/telegraf.d/config.conf:
  file.managed:
    - source: /tmp/config/telegraf/telegraf.conf
    - user: telegraf
    - group: telegraf
    - mode: 660
