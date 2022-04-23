terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"    
}

provider "aws" {
  alias = "us-east-2"
  profile = "default"
  region  = "us-east-2"    
}

resource "aws_instance" "dev" {
    count         = 3 #Contador para criar 3 máquinas em um unico resource
    ami           = "ami-0e472ba40eb589f49"
    instance_type = "t2.micro"
    key_name      = var.key_name
    tags = {
        Name = "dev${count.index}"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"] #ID do Security Group
}

resource "aws_instance" "dev4" {
    ami           = "ami-0e472ba40eb589f49"
    instance_type = "t2.micro"
    key_name      = var.key_name
    tags = {
        Name = "dev4"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"] #ID do Security Group
    depends_on = [aws_s3_bucket.dev4]
}

resource "aws_instance" "dev5" {
    ami           = var.amis["us-east-1"]
    instance_type = "t2.micro"
    key_name      = var.key_name
    tags = {
        Name = "dev5"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh.id}"] #ID do Security Group
}

#Maquina provisionada em outra região da AWS
resource "aws_instance" "dev6" {
    provider      = "aws.us-east-2"
    ami           = var.amis["us-east-2"]
    instance_type = "t2.micro"
    key_name      = var.key_name
    tags = {
        Name = "dev6"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"] #ID do Security Group
    depends_on = ["aws_dynamodb_table.dynamodb-homologacao"]
}

resource "aws_instance" "dev7" {
    provider      = "aws.us-east-2"
    ami           = var.amis["us-east-2"]
    instance_type = "t2.micro"
    key_name      = var.key_name
    tags = {
        Name = "dev7"
    }
    vpc_security_group_ids = ["${aws_security_group.acesso-ssh-us-east-2.id}"] #ID do Security Group
}

#Bucket para a máquina Dev4
resource "aws_s3_bucket" "dev4" {
  bucket = "allan-dev4"
  #acl    = "private"

  tags = {
    name = "allan-dev4"
  }
  
}

resource "aws_dynamodb_table" "dynamodb-homologacao" {
  provider = "aws.us-east-2"
  name           = "GameScores"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}


