provider "vault" {}

resource "vault_auth_backend" "github_example" {
  type = "github"
}

resource "vault_auth_backend" "aws_example" {
  type = "aws"
}

resource "vault_audit" "test" {
  type = "socket"
  path = "app_socket"

  options = {
    address     = "127.0.0.1:8000"
    socket_type = "tcp"
    description = "application x socket"
  }
}
