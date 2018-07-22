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

firewall forward drop:
  iptables.set_policy:
    - chain: FORWARD
    - policy: DROP
