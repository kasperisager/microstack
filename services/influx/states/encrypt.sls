/etc/influx.d/ssl/ca.key:
  x509.private_key_managed:
    - bits: 4096

/etc/influx.d/ssl/ca.cert:
  x509.certificate_managed:
    - signing_private_key: /etc/influx.d/ssl/ca.key
    - basicConstraints: CA:true
    - days_valid: 3650
    - days_remaining: 0

/etc/influx.d/ssl/influx.key:
  x509.private_key_managed:
    - bits: 4096

/etc/influx.d/ssl/influx.cert:
  x509.certificate_managed:
    - signing_private_key: /etc/influx.d/ssl/ca.key
    - signing_cert: /etc/influx.d/ssl/ca.cert
    - public_key: /etc/influx.d/ssl/influx.key
    - subjectKeyIdentifier: hash
    - CN: "influxdb.service.consul"
    - days_valid: 3650
    - days_remaining: 0
  file.append:
    - source: /etc/influx.d/ssl/influx.key

influx certificate permissions:
  file.directory:
    - name: /etc/influx.d/ssl/
    - user: influx
    - group: influx
    - file_mode: 660
    - recurse:
      - user
      - group
      - mode
