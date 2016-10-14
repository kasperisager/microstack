/mnt/persist/influx:
  file.directory:
    - user: influx
    - group: influx
  service.running:
    - name: influx

/mnt/persist/chronograf:
  file.directory:
    - user: chronograf
    - group: chronograf
  service.running:
    - name: chronograf
