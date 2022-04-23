variable "amis" {
  type = map

  default = {
      "us-east-1" = "ami-0e472ba40eb589f49"
      "us-east-2" = "ami-0c6a6b0e75b2b6ce7"

  }
}

variable "cdirs_acesso_remoto" {
  type = list
  default = ["179.183.183.219/32"] #Variavel do meu IP
}

variable "key_name" {
    default = "terraform-aws"  
}