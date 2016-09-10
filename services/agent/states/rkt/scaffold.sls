{% for directory in
  "/opt/rkt/",
  "/opt/rkt/bin/"
%}
{{directory}}:
  file.directory:
    - user: root
{% endfor %}
