firewall forward docker0:
  iptables.append:
    - chain: FORWARD
    - jump: ACCEPT
    - in-interface: docker0
    - out-interface: eth0
    - save: true

firewall forward eth0:
  iptables.append:
    - chain: FORWARD
    - jump: ACCEPT
    - in-interface: eth0
    - out-interface: docker0
    - save: true
