consul:
  group.present: []
  user.present:
    - shell: /usr/sbin/nologin
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

{% for directory in
  "/etc/microstack.d/",
  "/etc/microstack.d/ssl/"
%}
{{directory}}:
  file.directory: []
{% endfor %}

packages:
  pkg.installed:
    - pkgs:
      - iptables-persistent
      - python-m2crypto

salt-minion:
  service.dead:
    - enable: false
