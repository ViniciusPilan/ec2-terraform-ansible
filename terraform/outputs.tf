output "instance_id" {
    value = aws_instance.server.id
}

output "instance_name" {
    value = aws_instance.server.tags.Name
}

output "ami_id" {
    value = aws_instance.server.ami
}

output "instance_public_ipv4" {
    value = aws_instance.server.public_ip
}

output "instance_public_dns" {
    value = aws_instance.server.public_dns
}

