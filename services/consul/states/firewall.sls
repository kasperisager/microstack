CLUSTER:
  iptables.chain_present: []

CONSUL:
  iptables.chain_present: []

firewall allow ssh:
  iptables.append:
    - chain: INPUT
    - jump: ACCEPT
    - dport: ssh
    - proto: tcp
    - save: true

firewall allow stateful:
  iptables.append:
    - chain: INPUT
    - jump: ACCEPT
    - match: conntrack
    - ctstate: RELATED,ESTABLISHED
    - save: true

firewall allow loopback:
  iptables.append:
    - chain: INPUT
    - jump: ACCEPT
    - in-interface: lo
    - save: true

firewall input drop:
  iptables.set_policy:
    - chain: INPUT
    - policy: DROP

firewall cluster jump:
  iptables.append:
    - chain: INPUT
    - jump: CLUSTER
    - save: true

firewall consul jump:
  iptables.append:
    - chain: INPUT
    - jump: CONSUL
    - save: true

{% for port in 8300, 8301, 8302, 8400 %}
firewall tcp {{port}}:
  iptables.append:
    - chain: CONSUL
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
    - chain: CONSUL
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
