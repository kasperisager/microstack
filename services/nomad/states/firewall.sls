iptables-persistent:
  pkg.installed: []

{% for port in 4646, 4647, 4648 %}
firewall tcp {{port}}:
  iptables.append:
    - chain: INPUT
    - jump: ACCEPT
    - dport: {{port}}
    - proto: tcp
    - save: true
{% endfor %}
