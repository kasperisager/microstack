/tmp/rkt/:
  archive.extracted:
    - source: https://github.com/coreos/rkt/releases/download/v1.30.0/rkt-v1.30.0.tar.gz
    - source_hash: sha256=812b7d80ae66634286df3eb6d954cc99836aebcd79808b9ee2751dfd1f54421c
    - archive_format: tar

{% for file in
  "rkt",
  "stage1-coreos.aci",
  "stage1-fly.aci",
  "stage1-kvm.aci"
%}
/opt/rkt/bin/{{file}}:
  file.managed:
    - source: /tmp/rkt/rkt-v1.30.0/{{file}}
    - mode: 700

/usr/bin/{{file}}:
  file.symlink:
    - target: /opt/rkt/bin/{{file}}
    - mode: 700
{% endfor %}
