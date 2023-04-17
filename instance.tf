resource "aws_instance" "web" {
  ami                         = var.image_id     #"ami-00b3e95ade0a05b9b"
  instance_type               = var.inst_type[1] // or var.inst_type[0], var.inst_type[2]
  count                       = var.inst_count
  availability_zone           = "us-east-1c"
  key_name                    = "awsdemokey"
  vpc_security_group_ids      = [aws_security_group.allow_http_ssh.id]

  tags = var.ec2_instance_tags
}
