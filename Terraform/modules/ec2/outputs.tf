output "key_name" {
  value = aws_key_pair.ec2_key.key_name
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "jenkins_master_instance_id" {
  value = aws_instance.jenkins_master.id
}

output "jenkins_slave_instance_id" {
  value = aws_instance.jenkins_slave.id
}

output "nodejs_app1_id" {
  value = aws_instance.nodejs_app1.id
}

output "nodejs_app2_id" {
  value = aws_instance.nodejs_app2.id
}

output "nodejs_app1_private_ip" {
  description = "Private IP of Node.js App1 EC2 instance"
  value       = aws_instance.nodejs_app1.private_ip
}

output "nodejs_app2_private_ip" {
  description = "Private IP of Node.js App2 EC2 instance"
  value       = aws_instance.nodejs_app2.private_ip
}
