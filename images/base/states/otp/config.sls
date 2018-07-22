/etc/otp.d/otp.hcl:
  file.managed:
    - source: /tmp/config/otp/otp.hcl
    - user: otp
    - group: otp
    - mode: 640

/etc/pam.d/sshd:
  file.prepend:
    - text: |
        # Vault OTP authentication.
        auth sufficient pam_exec.so quiet expose_authtok log=/tmp/otp.log /usr/bin/otp -config=/etc/otp.d/otp.hcl
