resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = "default"
  public_key = tls_private_key.this.public_key_openssh
}

resource "local_sensitive_file" "private_key" {
  content         = tls_private_key.this.private_key_pem
  file_permission = "0600"
  filename        = "ansible/key"
}

resource "local_sensitive_file" "public_key" {
  content         = tls_private_key.this.public_key_pem
  file_permission = "0644"
  filename        = "ansible/key.pub"
}
