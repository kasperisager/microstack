/tmp/vault/:
  archive.extracted:
    - source: https://releases.hashicorp.com/vault/0.6.1/vault_0.6.1_linux_amd64.zip
    - source_hash: sha256=4f248214e4e71da68a166de60cc0c1485b194f4a2197da641187b745c8d5b8be
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
