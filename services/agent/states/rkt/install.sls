/tmp/rkt/:
  archive.extracted:
    - source: https://github.com/coreos/rkt/releases/download/v1.21.0/rkt-v1.21.0.tar.gz
    - source_hash: sha256=7d99297a1c36231a13076f9b47ed5ffe52aa1cf82be249f7ce3ee1064fab7735
    - archive_format: tar

{% for file in
  "rkt",
  "stage1-coreos.aci",
  "stage1-fly.aci",
  "stage1-kvm.aci"
%}
/opt/rkt/bin/{{file}}:
  file.managed:
    - source: /tmp/rkt/rkt-v1.21.0/{{file}}
    - mode: 700

/usr/bin/{{file}}:
  file.symlink:
    - target: /opt/rkt/bin/{{file}}
    - mode: 700
{% endfor %}
