/tmp/docker/:
  archive.extracted:
    - source: https://get.docker.com/builds/Linux/x86_64/docker-1.12.1.tgz
    - source_hash: sha256=05ceec7fd937e1416e5dce12b0b6e1c655907d349d52574319a1e875077ccb79
    - archive_format: tar

{% for file in
  "docker",
  "docker-containerd",
  "docker-containerd-ctr",
  "docker-containerd-shim",
  "docker-proxy",
  "docker-runc",
  "dockerd"
%}
/opt/docker/bin/{{file}}:
  file.managed:
    - source: /tmp/docker/docker/{{file}}
    - group: docker
    - mode: 760

/usr/bin/{{file}}:
  file.symlink:
    - target: /opt/docker/bin/{{file}}
    - group: docker
    - mode: 760
{% endfor %}
