/tmp/docker/:
  archive.extracted:
    - source: https://get.docker.com/builds/Linux/x86_64/docker-1.12.3.tgz
    - source_hash: sha256=626601deb41d9706ac98da23f673af6c0d4631c4d194a677a9a1a07d7219fa0f
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
    - mode: 750

/usr/bin/{{file}}:
  file.symlink:
    - target: /opt/docker/bin/{{file}}
    - group: docker
    - mode: 750
{% endfor %}
