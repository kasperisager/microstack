iptables-persistent:
  pkg.installed: []

{% for port in 8300, 8301, 8302, 8400, 8500, 8600 %}
firewall tcp {{port}}:
  iptables.append:
    - chain: INPUT
    - jump: ACCEPT
    - dport: {{port}}
    - proto: tcp
    - save: true
{% endfor %}

{% for port in 8301, 8302, 8600 %}
firewall udp {{port}}:
  iptables.append:
    - chain: INPUT
    - jump: ACCEPT
    - dport: {{port}}
    - proto: udp
    - save: true
{% endfor %}
