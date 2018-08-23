#!/bin/bash

vault write database/config/my-mysql-database \
plugin_name=mysql-database-plugin \
connection_url="{{username}}:{{password}}@tcp(db:3306)/" \
allowed_roles="read-only" \
username="root" \
password="dbpassword"

vault write database/roles/read-only \
db_name=my-mysql-database \
creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON *.* TO '{{name}}'@'%';" \
default_ttl="1h" \
max_ttl="24h"
