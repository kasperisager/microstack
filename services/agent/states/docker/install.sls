/tmp/docker/:
  archive.extracted:
    - source: https://download.docker.com/linux/static/stable/x86_64/docker-18.03.1-ce.tgz
    - source_hash: sha256=0e245c42de8a21799ab11179a4fce43b494ce173a8a2d6567ea6825d6c5265aa
    - archive_format: tar

{% for file in
  "docker",
  "docker-containerd",
  "docker-containerd-ctr",
  "docker-containerd-shim",
  "docker-init",
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
