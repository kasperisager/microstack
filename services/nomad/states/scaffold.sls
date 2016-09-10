nomad:
  group.present: []
  user.present:
    - shell: /sbin/nologin
    - createhome: false
    - groups:
      - nomad

{% for directory in
  "/opt/nomad/",
  "/opt/nomad/bin/",
  "/var/nomad/",
  "/etc/nomad.d/"
%}
{{directory}}:
  file.directory:
    - user: nomad
    - group: nomad
{% endfor %}
