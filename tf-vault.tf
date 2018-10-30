provider "vault" {}

resource "vault_auth_backend" "github_example" {
  type = "github"
}

resource "vault_auth_backend" "aws_example" {
  type = "aws"
}
