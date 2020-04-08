provider "aws" {
  region = "eu-west-1"
}

resource "aws_key_pair" "this" {
  key_name   = "mdu_private"
  public_key = file("key.pub")
}

resource "aws_security_group" "this" {
  name   = "jitsi"
  vpc_id = "vpc-0034032d3885717f4"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["86.192.244.11/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "this" {
  ami           = "ami-03d8261f577d71b6a"
  instance_type = "t2.small"
  key_name      = aws_key_pair.this.key_name
  user_data     = file("bootstrap.sh")
  monitoring    = true
  subnet_id     = "subnet-06a7524582aa1751a"

  vpc_security_group_ids = [
    aws_security_group.this.id
  ]

  tags = {
    app  = "jitsi"
    name = "jitsi"
  }
}

output "public_ip" {
  value = aws_instance.this.public_ip
}
