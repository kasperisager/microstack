/tmp/vault/:
  archive.extracted:
    - source: https://releases.hashicorp.com/vault/0.6.4/vault_0.6.4_linux_amd64.zip
    - source_hash: sha256=04d87dd553aed59f3fe316222217a8d8777f40115a115dac4d88fac1611c51a6
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
