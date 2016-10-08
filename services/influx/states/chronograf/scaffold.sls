chronograf:
  group.present: []
  user.present:
    - shell: /usr/sbin/nologin
    - createhome: false
    - groups:
      - chronograf

{% for directory in
  "/opt/chronograf/",
  "/opt/chronograf/bin/",
  "/var/chronograf/",
  "/etc/chronograf.d/"
%}
{{directory}}:
  file.directory:
    - user: chronograf
    - group: chronograf
{% endfor %}
