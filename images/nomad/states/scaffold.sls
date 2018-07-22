nomad:
  group.present: []
  user.present:
    - shell: /usr/sbin/nologin
    - createhome: false
    - groups:
      - nomad

{% for directory in
  "/opt/nomad/",
  "/opt/nomad/bin/",
  "/var/nomad/",
  "/etc/nomad.d/",
  "/etc/nomad.d/ssl/"
%}
{{directory}}:
  file.directory:
    - user: nomad
    - group: nomad
{% endfor %}
