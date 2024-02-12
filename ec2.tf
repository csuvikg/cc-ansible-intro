data "aws_ami" "this" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "this" {
  count                  = 2
  ami                    = data.aws_ami.this.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.this.key_name
  subnet_id              = data.aws_subnet.this.id
  vpc_security_group_ids = [aws_security_group.this.id]

  tags = {
    Name     = format(local.instance_name_pattern, count.index + 1)
  }
}

resource "aws_eip" "this" {
  count    = 2
  instance = aws_instance.this[count.index].id

  tags = {
    Name = format(local.instance_name_pattern, count.index + 1)
  }
}
