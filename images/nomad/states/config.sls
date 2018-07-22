/etc/systemd/system/nomad.service:
  file.managed:
    - source: /tmp/config/nomad.service

/etc/systemd/system/nomad.path:
  file.managed:
    - source: /tmp/config/nomad.path
  service.enabled:
    - name: nomad.path

/etc/nomad.d/config.hcl:
  file.managed:
    - source: /tmp/config/nomad.hcl
    - template: jinja
    - user: nomad
    - group: nomad
    - mode: 640
