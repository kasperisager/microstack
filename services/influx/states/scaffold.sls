influx:
  group.present: []
  user.present:
    - shell: /sbin/nologin
    - createhome: false
    - groups:
      - influx

{% for directory in
  "/opt/influx/",
  "/opt/influx/bin/",
  "/var/influx/",
  "/etc/influx.d/"
%}
{{directory}}:
  file.directory:
    - user: influx
    - group: influx
{% endfor %}
