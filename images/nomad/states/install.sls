/tmp/nomad/:
  archive.extracted:
    - source: https://releases.hashicorp.com/nomad/0.8.4/nomad_0.8.4_linux_amd64.zip
    - source_hash: sha256=42fc455d09ea0085cc79d7be4fb2089a9ab7db3cc2e8047e8437855a81b090e9
    - archive_format: zip
    - enforce_toplevel: false

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
