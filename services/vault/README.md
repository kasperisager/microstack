# Microstack: Vault

## Setup

Vault is the only service that requires manual configuration due to its strict security model.

### Connecting

```console
$ export VAULT_ADDR=https://<ip>:8200
$ export VAULT_TLS_SERVER_NAME=vault.service.consul
$ export VAULT_CAPATH=./microstack.crt
```

### Initialising

```console
$ vault init
$ vault unseal # Repeat until unsealed
$ vault auth
```

### SSH One-Time Passwords

The example below will create a role named `admin` that will give access to the `root` user on any node in the infrastructure.

```console
$ vault mount ssh
$ vault write ssh/roles/admin key_type=otp default_user=root
$ vault write ssh/config/zeroaddress roles=admin
```

```console
$ vault ssh -role admin root@<ip>
```
