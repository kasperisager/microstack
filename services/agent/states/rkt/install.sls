/tmp/rkt/:
  archive.extracted:
    - source: https://github.com/coreos/rkt/releases/download/v1.19.0/rkt-v1.19.0.tar.gz
    - source_hash: sha256=6c9f3ef067fd02fa6719b244d9ee7991a11c3f464f359441ff96faf1c663edb1
    - archive_format: tar

{% for file in
  "rkt",
  "stage1-coreos.aci",
  "stage1-fly.aci",
  "stage1-kvm.aci"
%}
/opt/rkt/bin/{{file}}:
  file.managed:
    - source: /tmp/rkt/rkt-v1.19.0/{{file}}
    - mode: 700

/usr/bin/{{file}}:
  file.symlink:
    - target: /opt/rkt/bin/{{file}}
    - mode: 700
{% endfor %}
