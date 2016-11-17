/tmp/nomad/:
  archive.extracted:
    - source: https://releases.hashicorp.com/nomad/0.5.0/nomad_0.5.0_linux_amd64.zip
    - source_hash: sha256=7f7b9af2b1ff3e2c6b837b6e95968415237bb304e1e82802bc42abf6f8645a43
    - archive_format: zip

/opt/nomad/bin/nomad:
  file.managed:
    - source: /tmp/nomad/nomad
    - user: nomad
    - group: nomad
    - mode: 750

/usr/bin/nomad:
  file.symlink:
    - target: /opt/nomad/bin/nomad
    - user: nomad
    - group: nomad
    - mode: 750
