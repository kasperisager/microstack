/opt/fabio/bin/:
  file.directory:
    - user: fabio
    - group: fabio

/opt/fabio/bin/fabio:
  file.managed:
    - source: https://github.com/eBay/fabio/releases/download/v1.2.1/fabio-1.2.1-go1.7_linux-amd64
    - source_hash: sha256=2eea2b36e10a1d5c00dc281542dcd36174d6288c6045b323767b47cfcf24f153
    - user: fabio
    - group: fabio
    - mode: 700
