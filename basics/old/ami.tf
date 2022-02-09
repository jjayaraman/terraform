provider "aws" {
  profile = "jay"
  region  = "eu-west-2"
}

resource "aws_instance" "jay_ami" {
  ami             = "ami-0596aab74a1ce3983"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instance.name]
  tags = {
    "group" : "jay"
  }
}

resource "aws_security_group" "instance" {
  name = "instance_security_group"

  ingress {
    from_port   = 8080
    protocol    = "tcp"
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

}