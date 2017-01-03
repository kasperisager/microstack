/tmp/nomad/:
  archive.extracted:
    - source: https://releases.hashicorp.com/nomad/0.5.2/nomad_0.5.2_linux_amd64.zip
    - source_hash: sha256=7f23aa44686b2ae505ecfc5364a43f87c2a029ea03f6ab050384f2a2b32ac648
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
