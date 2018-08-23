# HashiCorp Vault Installation Checklist

## Setup

1. Initialize Vault
2. Unseal Vault

## Initial Configuration

1. Enable Auditing

2. Create Vault admins policy
```
vault policy write vault-admins ./policies/vault-admin-policy.hcl
```

3. Enable authentication method
```
vault enable auth
```

4. Configure authentication method
5. Add Vault Admin
6. Validate Vault Admin access
7. Revoke root token
