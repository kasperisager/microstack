telegraf:
  group.present: []
  user.present:
    - shell: /usr/sbin/nologin
    - createhome: false
    - groups:
      - telegraf

{% for directory in
  "/opt/telegraf/",
  "/opt/telegraf/bin/",
  "/etc/telegraf.d/"
%}
{{directory}}:
  file.directory:
    - user: telegraf
    - group: telegraf
{% endfor %}
