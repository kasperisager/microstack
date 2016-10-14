/etc/vault.d/ssh-helper.hcl:
  file.managed:
    - source: /tmp/config/vault/ssh-helper.hcl
    - user: vault
    - group: vault
    - mode: 640

/etc/pam.d/sshd:
  file.prepend:
    - text: |
        # Vault OTP authentication.
        auth sufficient pam_exec.so quiet expose_authtok log=/tmp/vaultssh.log /usr/bin/vault-ssh-helper -config=/etc/vault.d/ssh-helper.hcl
