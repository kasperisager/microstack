nomad:
  group.present: []
  user.present:
    - shell: /sbin/nologin
    - groups:
      - nomad

{% for directory in '/opt/nomad/', '/var/nomad/', '/etc/nomad.d/' %}
{{directory}}:
  file.directory:
    - user: nomad
    - group: nomad
{% endfor %}
