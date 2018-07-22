vault:
  group.present: []
  user.present:
    - shell: /usr/sbin/nologin
    - createhome: false
    - groups:
      - vault

{% for directory in
  "/opt/vault/",
  "/opt/vault/bin/",
  "/etc/vault.d/",
  "/etc/vault.d/ssl/"
%}
{{directory}}:
  file.directory:
    - user: vault
    - group: vault
{% endfor %}
