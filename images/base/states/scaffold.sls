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
