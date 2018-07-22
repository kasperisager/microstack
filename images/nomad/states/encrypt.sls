/etc/nomad.d/ssl/nomad.key:
  x509.private_key_managed:
    - bits: 4096

/etc/nomad.d/ssl/nomad.crt:
  x509.certificate_managed:
    - signing_private_key: /etc/microstack.d/ssl/ca.key
    - signing_cert: /etc/microstack.d/ssl/ca.crt
    - public_key: /etc/nomad.d/ssl/nomad.key
    - subjectKeyIdentifier: hash
    - CN: "nomad.service.consul"
    - days_valid: 3650
    - days_remaining: 0

certificate permissions:
  file.directory:
    - name: /etc/nomad.d/ssl/
    - user: nomad
    - group: nomad
    - file_mode: 640
    - recurse:
      - user
      - group
      - mode
