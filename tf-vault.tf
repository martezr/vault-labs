provider "vault" {}

resource "vault_auth_backend" "github_example" {
  type = "github"
}

resource "vault_auth_backend" "aws_example" {
  type = "aws"
}

resource "vault_audit" "test" {
  type = "file"

  options = {
    file_path = "/var/log/audit.log"
  }
}
