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
