base:
  "*":
    - docker.scaffold
    - docker.install
    - docker.config
    - docker.firewall

    - rkt.scaffold
    - rkt.install
    - rkt.config
