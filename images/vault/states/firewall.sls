VAULT:
  iptables.chain_present: []

firewall vault jump:
  iptables.append:
    - chain: INPUT
    - jump: VAULT
    - save: true

firewall tcp 8200:
  iptables.append:
    - chain: VAULT
    - jump: ACCEPT
    - dport: 8200
    - proto: tcp
    - match: limit
    - limit: 10/s
    - save: true
