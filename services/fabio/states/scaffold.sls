fabio:
  group.present: []
  user.present:
    - shell: /sbin/nologin
    - createhome: false
    - groups:
      - fabio

{% for directory in "/opt/fabio/", "/var/fabio/", "/etc/fabio.d/" %}
{{directory}}:
  file.directory:
    - user: fabio
    - group: fabio
{% endfor %}
