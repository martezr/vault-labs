# HashiCorp Vault Installation Checklist

1. Create Vault admins policy
```
vault policy write vault-admins ./policies/vault-admin-policy.hcl
```

2. Enable authentication method
```
vault enable auth
```

3. Configure authentication method
4. Add Vault Admin
5. Validate Vault Admin access
6. Revoke root token
