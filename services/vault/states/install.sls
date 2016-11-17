/tmp/vault/:
  archive.extracted:
    - source: https://releases.hashicorp.com/vault/0.6.2/vault_0.6.2_linux_amd64.zip
    - source_hash: sha256=91432c812b1264306f8d1ecf7dd237c3d7a8b2b6aebf4f887e487c4e7f69338c
    - archive_format: zip

/opt/vault/bin/vault:
  file.managed:
    - source: /tmp/vault/vault
    - user: vault
    - group: vault
    - mode: 750

/usr/bin/vault:
  file.symlink:
    - target: /opt/vault/bin/vault
    - user: vault
    - group: vault
    - mode: 750

vault allow mlock:
  cmd.run:
    - name: setcap cap_ipc_lock=+ep $(readlink -f $(which vault))
