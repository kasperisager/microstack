{% for file in
  "rkt-api.service",
  "rkt-gc.service",
  "rkt-gc.timer",
  "rkt-metadata.service",
  "rkt-metadata.socket"
%}
/etc/systemd/system/{{file}}:
  file.managed:
    - source: /tmp/rkt/rkt-v1.14.0/init/systemd/{{file}}
{% endfor %}

{% for service in
  "rkt-api",
  "rkt-gc",
  "rkt-metadata"
%}
{{service}}:
  service.enabled: []
{% endfor %}
