#!/bin/bash

# Create Vault Admins policy
vault policy write vault-admins ./vault-admins-policy.hcl

# Enable vault user/password authentication
vault auth enable userpass

# Create Admin user
vault write auth/userpass/users/admin password=vaultpassword policies=vault-admins
