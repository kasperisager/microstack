docker:
  group.present: []

nomad:
  user.present:
    - remove_groups: false
    - optional_groups:
      - docker

{% for directory in
  "/opt/docker/",
  "/opt/docker/bin/",
  "/etc/docker.d/"
%}
{{directory}}:
  file.directory:
    - group: docker
{% endfor %}
