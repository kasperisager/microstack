FABIO:
  iptables.chain_present: []

firewall fabio jump:
  iptables.append:
    - chain: INPUT
    - jump: FABIO
    - save: true

firewall tcp 9999:
  iptables.append:
    - chain: FABIO
    - jump: ACCEPT
    - dport: 9999
    - proto: tcp
    - save: true

{% for port in 80, 443 %}
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
