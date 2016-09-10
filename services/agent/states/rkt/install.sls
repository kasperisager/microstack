/tmp/rkt/:
  archive.extracted:
    - source: https://github.com/coreos/rkt/releases/download/v1.14.0/rkt-v1.14.0.tar.gz
    - source_hash: sha256=7e7c122f92f1dd8e621580869903a367e6ba2dd80f3ab9bf40b089d972d0c827
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
