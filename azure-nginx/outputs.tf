output "vm_id" {
  description = "Azure VM resource ID"
  value       = azurerm_linux_virtual_machine.nginx.id
}

output "public_ip" {
  description = "Public IP address of the nginx VM"
  value       = azurerm_public_ip.nginx.ip_address
}

output "nginx_url" {
  description = "URL to access the nginx server"
  value       = "http://${azurerm_public_ip.nginx.ip_address}"
}

output "ssh_command" {
  description = "SSH command to connect to the VM"
  value       = "ssh -i nginx-key.pem ${var.admin_username}@${azurerm_public_ip.nginx.ip_address}"
}

output "ssh_private_key_path" {
  description = "Path to the generated SSH private key"
  value       = local_sensitive_file.ssh_private_key.filename
}
