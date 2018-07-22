otp:
  group.present: []
  user.present:
    - shell: /usr/sbin/nologin
    - createhome: false
    - groups:
      - otp

{% for directory in
  "/opt/otp/",
  "/opt/otp/bin/",
  "/etc/otp.d/"
%}
{{directory}}:
  file.directory:
    - user: otp
    - group: otp
{% endfor %}
