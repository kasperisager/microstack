/etc/vault.d/ssl/ca.key:
  x509.private_key_managed:
    - bits: 4096

/etc/vault.d/ssl/ca.cert:
  x509.certificate_managed:
    - signing_private_key: /etc/vault.d/ssl/ca.key
    - basicConstraints: CA:true
    - days_valid: 3650
    - days_remaining: 0

vault certificate permissions:
  file.directory:
    - name: /etc/vault.d/ssl/
    - user: vault
    - group: vault
    - file_mode: 660
    - recurse:
      - user
      - group
      - mode
