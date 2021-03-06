/etc/consul.d/ssl/consul.key:
  x509.private_key_managed:
    - bits: 4096

/etc/consul.d/ssl/consul.crt:
  x509.certificate_managed:
    - signing_private_key: /etc/microstack.d/ssl/ca.key
    - signing_cert: /etc/microstack.d/ssl/ca.crt
    - public_key: /etc/consul.d/ssl/consul.key
    - subjectKeyIdentifier: hash
    - extendedKeyUsage: serverAuth,clientAuth
    - CN: "consul.service.consul"
    - days_valid: 3650
    - days_remaining: 0

consul certificate permissions:
  file.directory:
    - name: /etc/consul.d/ssl/
    - user: consul
    - group: consul
    - file_mode: 640
    - recurse:
      - user
      - group
      - mode
