{% for port in 80, 443 %}
firewall tcp {{port}}:
  iptables.append:
    - chain: INPUT
    - jump: ACCEPT
    - dport: {{port}}
    - proto: tcp
    - save: true

firewall http prerouting {{port}}:
  iptables.append:
    - table: nat
    - chain: PREROUTING
    - jump: REDIRECT
    - dport: {{port}}
    - to-ports: 9999
    - proto: tcp
    - save: true

firewall http output {{port}}:
  iptables.append:
    - table: nat
    - chain: OUTPUT
    - jump: REDIRECT
    - destination: localhost
    - dport: {{port}}
    - to-ports: 9999
    - proto: tcp
    - save: true
{% endfor %}
