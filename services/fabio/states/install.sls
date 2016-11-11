/opt/fabio/bin/fabio:
  file.managed:
    - source: https://github.com/eBay/fabio/releases/download/v1.3.4/fabio-1.3.4-go1.7.3-linux_amd64
    - source_hash: sha256=ae98704f524a678d19641bfaaea3cd73040507e47b3bda3fff911fb7fd42a83d
    - user: fabio
    - group: fabio
    - mode: 750

/usr/bin/fabio:
  file.symlink:
    - target: /opt/fabio/bin/fabio
    - user: fabio
    - group: fabio
    - mode: 750
