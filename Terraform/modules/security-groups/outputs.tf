output "bastion_sg" {
  value = aws_security_group.bastion_sg.id
}

output "master_sg" {
  value = aws_security_group.master_sg.id
}

output "slave_sg" {
  value = aws_security_group.slave_sg.id
}

output "alb_sg" {
  value = aws_security_group.alb_sg.id
}

output "app_sg" {
  value = aws_security_group.app_sg.id
}
