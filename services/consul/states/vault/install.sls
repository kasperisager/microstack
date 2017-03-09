/tmp/vault-ssh-helper/:
  archive.extracted:
    - source: https://releases.hashicorp.com/vault-ssh-helper/0.1.2/vault-ssh-helper_0.1.2_linux_amd64.zip
    - source_hash: sha256=bfe5efd19ea5e0f6b45e60f9631620314a8cbe8e829c6fb3ba7ca6875dc6b37b
    - archive_format: zip
    - enforce_toplevel: false

/opt/vault/bin/ssh-helper:
  file.managed:
    - source: /tmp/vault-ssh-helper/vault-ssh-helper
    - user: vault
    - group: vault
    - mode: 750

/usr/bin/vault-ssh-helper:
  file.symlink:
    - target: /opt/vault/bin/ssh-helper
    - user: vault
    - group: vault
    - mode: 750
