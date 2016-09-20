/etc/systemd/system/vault.service:
  file.managed:
    - source: /tmp/config/vault.service

/etc/vault.d/config.hcl:
  file.managed:
    - source: /tmp/config/vault.hcl
    - user: vault
    - group: vault
    - mode: 660
