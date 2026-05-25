terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
  zone    = var.gcp_zone
}

# ---------------------------------------------------------------------------
# Firewall rules
# ---------------------------------------------------------------------------

resource "google_compute_firewall" "allow_http" {
  name    = "nginx-allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["nginx-server"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "nginx-allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [var.ssh_allowed_cidr]
  target_tags   = ["nginx-server"]
}

# ---------------------------------------------------------------------------
# Static external IP
# ---------------------------------------------------------------------------

resource "google_compute_address" "nginx" {
  name   = "nginx-static-ip"
  region = var.gcp_region
}

# ---------------------------------------------------------------------------
# Compute instance
# ---------------------------------------------------------------------------

resource "google_compute_instance" "nginx" {
  name         = "nginx-vm"
  machine_type = var.machine_type
  zone         = var.gcp_zone
  tags         = ["nginx-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = google_compute_address.nginx.address
    }
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx
    systemctl start nginx
    systemctl enable nginx
  EOF

  labels = {
    name = "nginx-vm"
  }
}
