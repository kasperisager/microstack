/tmp/vault/:
  archive.extracted:
    - source: https://releases.hashicorp.com/vault/0.10.3/vault_0.10.3_linux_amd64.zip
    - source_hash: sha256=ffec1c201f819f47581f54c08653a8d17ec0a6699854ebd7f6625babb9e290ed
    - archive_format: zip
    - enforce_toplevel: false

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
