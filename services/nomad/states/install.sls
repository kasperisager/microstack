/tmp/nomad/:
  archive.extracted:
    - source: https://releases.hashicorp.com/nomad/0.4.1/nomad_0.4.1_linux_amd64.zip
    - source_hash: sha256=0cdb5dd95c918c6237dddeafe2e9d2049558fea79ed43eacdfcd247d5b093d67
    - archive_format: zip

/opt/nomad/bin/:
  file.directory:
    - user: nomad
    - group: nomad

/opt/nomad/bin/nomad:
  file.managed:
    - source: /tmp/nomad/nomad
    - user: consul
    - group: consul
    - mode: 700

/usr/bin/nomad:
  file.symlink:
    - target: /opt/nomad/bin/nomad
    - user: consul
    - group: consul
    - mode: 700
