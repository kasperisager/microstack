/etc/vault.d/ssl/vault.key:
  x509.private_key_managed:
    - bits: 4096

/etc/vault.d/ssl/vault.crt:
  x509.certificate_managed:
    - signing_private_key: /etc/microstack.d/ssl/ca.key
    - signing_cert: /etc/microstack.d/ssl/ca.crt
    - public_key: /etc/vault.d/ssl/vault.key
    - subjectKeyIdentifier: hash
    - CN: "vault.service.consul"
    - days_valid: 3650
    - days_remaining: 0

certificate permissions:
  file.directory:
    - name: /etc/vault.d/ssl/
    - user: vault
    - group: vault
    - file_mode: 660
    - recurse:
      - user
      - group
      - mode
