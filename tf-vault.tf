provider "vault" {}

resource "vault_auth_backend" "github_example" {
  type = "github"
}

resource "vault_auth_backend" "aws_example" {
  type = "aws"
}

resource "vault_mount" "db" {
  path = "postgres"
  type = "database"
}

resource "vault_database_secret_backend_connection" "postgres" {
  backend       = "${vault_mount.db.path}"
  name          = "postgres-database"
  allowed_roles = ["dev", "prod"]
  verify_connection = false

  postgresql {
    connection_url = "postgres://root:password@postgresdb:5432/database"
  }
}

resource "vault_database_secret_backend_role" "role" {
  backend             = "${vault_mount.db.path}"
  name                = "postgresdb-prod"
  db_name             = "${vault_database_secret_backend_connection.postgres.name}"
  creation_statements = "CREATE ROLE {{name}} WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';"
}
