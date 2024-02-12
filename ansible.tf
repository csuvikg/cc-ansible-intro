resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.jinja", {
    ips = aws_instance.this.*.public_ip
  })
  file_permission = "0644"
  filename        = "ansible/inventory.ini"
}

output "ip_addresses" {
  value = aws_instance.this.*.public_ip
}
