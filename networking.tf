data "aws_vpc" "this" {
  default = true
} 

data "aws_subnet" "this" {
  vpc_id     = data.aws_vpc.this.id
  filter {
    name   = "availability-zone"
    values = ["eu-central-1a"]
  }
}

resource "aws_security_group" "this" {
  vpc_id = data.aws_vpc.this.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
