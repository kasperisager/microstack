/etc/microstack.d/ssl/ca.key:
  x509.private_key_managed:
    - bits: 4096

/etc/microstack.d/ssl/ca.crt:
  x509.certificate_managed:
    - signing_private_key: /etc/microstack.d/ssl/ca.key
    - basicConstraints: CA:true
    - days_valid: 3650
    - days_remaining: 0
  file.managed:
    - mode: 644

/usr/local/share/ca-certificates/microstack.crt:
  file.managed:
    - source: /etc/microstack.d/ssl/ca.crt
  cmd.run:
    - name: update-ca-certificates
