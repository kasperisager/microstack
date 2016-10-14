/etc/systemd/system/vault.service:
  file.managed:
    - source: /tmp/config/vault.service

/etc/systemd/system/vault.path:
  file.managed:
    - source: /tmp/config/vault.path
  service.enabled:
    - name: vault.path

/etc/vault.d/config.hcl:
  file.managed:
    - source: /tmp/config/vault.hcl
    - user: vault
    - group: vault
    - mode: 640
