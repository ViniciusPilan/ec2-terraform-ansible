output "load_balancer_id" {
    value = aws_instance.load_balancer.id
}

output "load_balancer_eip_public_ipv4" {
    value = aws_eip.lb_eip.public_ip
}

output "load_balancer_eip_public_dns" {
    value = aws_eip.lb_eip.public_dns
}

output "web_server_1_id" {
    value = aws_instance.web_server_1.id
}

output "web_server_1_eip_public_ipv4" {
    value = aws_eip.ws_1_eip.public_ip
}

output "web_server_1_eip_public_dns" {
    value = aws_eip.ws_1_eip.public_dns
}

output "web_server_2_id" {
    value = aws_instance.web_server_2.id
}

output "web_server_2_eip_public_ipv4" {
    value = aws_eip.ws_2_eip.public_ip
}

output "web_server_2_eip_public_dns" {
    value = aws_eip.ws_2_eip.public_dns
}

# output "bucket_ip" {
#     value = aws_s3_bucket.bucket_web_server.ip
# }