/opt/fabio/bin/fabio:
  file.managed:
    - source: https://github.com/eBay/fabio/releases/download/v1.3.5/fabio-1.3.5-go1.7.3-linux_amd64
    - source_hash: sha256=1ed94366f09ebfb28a5c4b64bcba6772469e55e592e0da8df3dfc5a3dc6f2520
    - user: fabio
    - group: fabio
    - mode: 750

/usr/bin/fabio:
  file.symlink:
    - target: /opt/fabio/bin/fabio
    - user: fabio
    - group: fabio
    - mode: 750
