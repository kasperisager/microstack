VAULT:
  iptables.chain_present: []

firewall vault jump:
  iptables.append:
    - chain: INPUT
    - jump: VAULT
    - save: true

firewall tcp 8200:
  iptables.insert:
    - chain: VAULT
    - jump: ACCEPT
    - position: 1
    - dport: 8200
    - proto: tcp
    - save: true
