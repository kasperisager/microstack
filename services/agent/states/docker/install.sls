/tmp/docker/:
  archive.extracted:
    - source: https://get.docker.com/builds/Linux/x86_64/docker-1.12.5.tgz
    - source_hash: sha256=0058867ac46a1eba283e2441b1bb5455df846144f9d9ba079e97655399d4a2c6
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
