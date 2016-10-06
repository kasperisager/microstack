/tmp/rkt/:
  archive.extracted:
    - source: https://github.com/coreos/rkt/releases/download/v1.16.0/rkt-v1.16.0.tar.gz
    - source_hash: sha256=2afb6ad62360665608f7297a71619adee06695359586442f58a81e1c782fb96c
    - archive_format: tar

{% for file in
  "rkt",
  "stage1-coreos.aci",
  "stage1-fly.aci",
  "stage1-kvm.aci"
%}
/opt/rkt/bin/{{file}}:
  file.managed:
    - source: /tmp/rkt/rkt-v1.14.0/{{file}}
    - mode: 700

/usr/bin/{{file}}:
  file.symlink:
    - target: /opt/rkt/bin/{{file}}
    - mode: 700
{% endfor %}
