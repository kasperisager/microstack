FABIO:
  iptables.chain_present: []

firewall fabio jump:
  iptables.append:
    - chain: INPUT
    - jump: FABIO
    - save: true

{% for port in 80, 443 %}
firewall tcp {{port}}:
  iptables.insert:
    - chain: FABIO
    - jump: ACCEPT
    - position: 1
    - dport: {{port}}
    - proto: tcp
    - save: true

firewall http prerouting {{port}}:
  iptables.insert:
    - table: nat
    - chain: PREROUTING
    - jump: REDIRECT
    - position: 1
    - dport: {{port}}
    - to-ports: 9999
    - proto: tcp
    - save: true

firewall http output {{port}}:
  iptables.insert:
    - table: nat
    - chain: OUTPUT
    - jump: REDIRECT
    - position: 1
    - destination: localhost
    - dport: {{port}}
    - to-ports: 9999
    - proto: tcp
    - save: true
{% endfor %}
