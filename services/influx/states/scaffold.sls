influx:
  group.present: []
  user.present:
    - shell: /usr/sbin/nologin
    - createhome: false
    - groups:
      - influx

{% for directory in
  "/opt/influx/",
  "/opt/influx/bin/",
  "/var/influx/",
  "/etc/influx.d/",
  "/etc/influx.d/ssl/"
%}
{{directory}}:
  file.directory:
    - user: influx
    - group: influx
{% endfor %}
