python-m2crypto:
  pkg.installed: []

/etc/consul.d/ssl/ca.key:
  x509.private_key_managed:
    - bits: 4096

/etc/consul.d/ssl/ca.cert:
  x509.certificate_managed:
    - signing_private_key: /etc/consul.d/ssl/ca.key
    - basicConstraints: CA:true
    - days_valid: 3650
    - days_remaining: 0

/etc/consul.d/ssl/consul.key:
  x509.private_key_managed:
    - bits: 4096

/etc/consul.d/ssl/consul.cert:
  x509.certificate_managed:
    - signing_private_key: /etc/consul.d/ssl/ca.key
    - signing_cert: /etc/consul.d/ssl/ca.cert
    - public_key: /etc/consul.d/ssl/consul.key
    - subjectKeyIdentifier: hash
    - extendedKeyUsage: serverAuth,clientAuth
    - CN: "*.consul"
    - days_valid: 3650
    - days_remaining: 0

certificate permissions:
  file.directory:
    - name: /etc/consul.d/ssl/
    - user: consul
    - group: consul
    - mode: 600
    - recurse:
      - user
      - group
      - mode
