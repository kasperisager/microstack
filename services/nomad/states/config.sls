/etc/systemd/system/nomad.service:
  file.managed:
    - source: /tmp/config/nomad.service
  service.enabled:
    - name: nomad

/etc/nomad.d/config.hcl:
  file.managed:
    - source: /tmp/config/nomad.hcl
    - user: nomad
    - group: nomad
