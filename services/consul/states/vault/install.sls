/tmp/vault-ssh-helper/:
  archive.extracted:
    - source: https://releases.hashicorp.com/vault-ssh-helper/0.1.4/vault-ssh-helper_0.1.4_linux_amd64.zip
    - source_hash: sha256=156ce8250725e64a3e4dc51018a18813dd44d1f2a6c853976bc20e1625d631a1
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
