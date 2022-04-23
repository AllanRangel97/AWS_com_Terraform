# Using a single workspace:
terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "CursoTerraformAluraAllan"

    workspaces {
      name = "aws-TerraformAlura"
    }
  }
}