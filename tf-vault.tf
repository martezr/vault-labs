provider "vault" {}

resource "vault_auth_backend" "userpass_authentication" {
  type = "userpass"
}

resource "vault_mount" "db" {
  path = "postgres"
  type = "database"
}

resource "vault_database_secret_backend_connection" "postgres" {
  backend       = "${vault_mount.db.path}"
  name          = "postgres"
  allowed_roles = ["dev", "prod"]

  postgresql {
    connection_url = "postgres://postgres:password@postgresdb:5432/postgres?sslmode=disable"
  }
}

resource "vault_database_secret_backend_role" "role" {
  backend             = "${vault_mount.db.path}"
  name                = "prod"
  db_name             = "${vault_database_secret_backend_connection.postgres.name}"
  creation_statements = "CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';"
}
