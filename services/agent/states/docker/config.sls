/etc/systemd/system/docker.service:
  file.managed:
    - source: /tmp/config/docker/docker.service

/etc/systemd/system/docker.socket:
  file.managed:
    - source: /tmp/config/docker/docker.socket

/etc/docker.d/daemon.json:
  file.managed:
    - source: /tmp/config/docker/docker.json
