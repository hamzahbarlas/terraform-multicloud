output "instance_name" {
  description = "Name of the Compute Engine instance"
  value       = google_compute_instance.nginx.name
}

output "instance_id" {
  description = "Unique ID of the Compute Engine instance"
  value       = google_compute_instance.nginx.instance_id
}

output "public_ip" {
  description = "Static public IP address of the nginx instance"
  value       = google_compute_address.nginx.address
}

output "nginx_url" {
  description = "URL to access the nginx server"
  value       = "http://${google_compute_address.nginx.address}"
}

output "ssh_command" {
  description = "gcloud command to SSH into the instance"
  value       = "gcloud compute ssh nginx-vm --zone=${var.gcp_zone} --project=${var.gcp_project_id}"
}
