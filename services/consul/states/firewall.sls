{% for port in 8300, 8301, 8302, 8400 %}
firewall tcp {{port}}:
  iptables.append:
    - chain: INPUT
    - jump: ACCEPT
    - dport: {{port}}
    - proto: tcp
    - match: limit
    - limit: 10/s
    - save: true
{% endfor %}

{% for port in 8301, 8302 %}
firewall udp {{port}}:
  iptables.append:
    - chain: INPUT
    - jump: ACCEPT
    - dport: {{port}}
    - proto: udp
    - match: limit
    - limit: 10/s
    - save: true
{% endfor %}

{% for proto in "tcp", "udp" %}
firewall dns prerouting {{proto}}:
  iptables.append:
    - table: nat
    - chain: PREROUTING
    - jump: REDIRECT
    - dport: 53
    - to-ports: 8600
    - proto: {{proto}}
    - save: true

firewall dns output {{proto}}:
  iptables.append:
    - table: nat
    - chain: OUTPUT
    - jump: REDIRECT
    - destination: localhost
    - dport: 53
    - to-ports: 8600
    - proto: {{proto}}
    - save: true
{% endfor %}

firewall allow ssh:
  iptables.append:
    - chain: INPUT
    - jump: ACCEPT
    - dport: 22
    - proto: tcp
    - save: true

firewall drop incoming:
  iptables.append:
    - chain: INPUT
    - jump: DROP
    - save: true
