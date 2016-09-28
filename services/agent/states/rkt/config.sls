{% for file in
  "rkt-api.service",
  "rkt-gc.service",
  "rkt-gc.timer",
  "rkt-metadata.service",
  "rkt-metadata.socket"
%}
/etc/systemd/system/{{file}}:
  file.managed:
    - source: /tmp/config/rkt/{{file}}
{% endfor %}

{% for service in
  "rkt-api",
  "rkt-gc.timer",
  "rkt-metadata"
%}
{{service}}:
  service.enabled: []
{% endfor %}
