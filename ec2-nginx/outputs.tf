output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.nginx.id
}

output "public_ip" {
  description = "Public IP address of the nginx server"
  value       = aws_instance.nginx.public_ip
}

output "public_dns" {
  description = "Public DNS name of the nginx server"
  value       = aws_instance.nginx.public_dns
}

output "nginx_url" {
  description = "URL to access the nginx server"
  value       = "http://${aws_instance.nginx.public_ip}"
}
