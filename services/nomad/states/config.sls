/etc/systemd/system/nomad.service:
  file.managed:
    - source: /tmp/config/nomad.service

/etc/nomad.d/config.hcl:
  file.managed:
    - source: /tmp/config/nomad.hcl
    - user: nomad
    - group: nomad
