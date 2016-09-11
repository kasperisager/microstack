consul:
  group.present: []
  user.present:
    - shell: /sbin/nologin
    - createhome: false
    - groups:
      - consul

{% for directory in
  "/opt/consul/",
  "/opt/consul/bin/",
  "/var/consul/",
  "/etc/consul.d/",
  "/etc/consul.d/ssl/"
%}
{{directory}}:
  file.directory:
    - user: consul
    - group: consul
{% endfor %}

packages:
  pkg.installed:
    - pkgs:
      - iptables-persistent
      - python-m2crypto
