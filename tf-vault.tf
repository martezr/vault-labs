provider "vault" {}

resource "vault_mount" "example" {
  path        = "dummy"
  type        = "aws"
  description = "This is an example mount"
}
