consul:
  group.present: []
  user.present:
    - shell: /sbin/nologin
    - groups:
      - consul

{% for directory in '/opt/consul/', '/var/consul/', '/etc/consul.d/' %}
{{directory}}:
  file.directory:
    - user: consul
    - group: consul
{% endfor %}
