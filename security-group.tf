#Configura Security Group na AWS
resource "aws_security_group" "acesso-ssh" {
  name        = "acesso-ssh"
  description = "acesso-ssh"

  ingress {
  #Configura acesso a porta 22 (SSH)
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.cdirs_acesso_remoto #Permite IP de acesso com váriavel definada no arquivo vars
  }

  tags = {
    Name = "ssh"
  }
}

resource "aws_security_group" "acesso-ssh-us-east-2" {
  provider = "aws.us-east-2"
  name        = "acesso-ssh"
  description = "acesso-ssh"

  ingress {
  #Configura acesso a porta 22 (SSH)
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.cdirs_acesso_remoto #Permite IP de acesso com váriavel definada no arquivo vars
  }

  tags = {
    Name = "ssh"
  }
}