# terraform-multicloud

Infrastructure-as-Code portfolio provisioning resources across AWS, Azure, and GCP using Terraform, with a GitHub Actions CI/CD pipeline.

## Overview

This portfolio demonstrates real multi-cloud infrastructure across AWS, Azure, and GCP, provisioned entirely through Terraform and secured using IAM access keys with least-privilege permissions. Every project is designed to minimize cost — using free tier instances, serverless compute that only charges on execution, and resources that can be fully destroyed in seconds when not in use. A GitHub Actions CI/CD pipeline automatically validates all Terraform configs on every push, catching errors before they ever reach real infrastructure. Along the way I worked through real-world cloud challenges including region capacity restrictions, VM SKU availability issues, and provider version conflicts — the same problems you run into in a production environment.

## Projects

- ec2-nginx - AWS EC2 t3.micro running nginx with security group
- azure-nginx - Azure Ubuntu 22.04 ARM64 VM running nginx with VNet and NSG
- aws-lambda-api - Serverless API using Lambda and API Gateway returning JSON
- gcp-nginx - GCP e2-micro Compute Engine VM running nginx with firewall rules

## Security

Security was something I focused on across every module, not an afterthought:

- AWS: Created a dedicated IAM user (terraform-user) instead of using the root account, so Terraform only has the access it actually needs. The Lambda function gets the minimum IAM permissions required — just enough to write logs.
- AWS Security Groups: Only ports 80 (HTTP) and 22 (SSH) are open inbound. Everything else is blocked by default.
- Azure: SSH uses an auto-generated 4096-bit RSA key instead of a password. The Network Security Group explicitly allows only HTTP and SSH traffic.
- GCP: Firewall rules are tied to a specific instance tag rather than opening traffic to the whole network, so only the intended VM is reachable.
- GitHub Actions: AWS credentials are stored as encrypted secrets in GitHub and injected at runtime — nothing sensitive is written in the code.

## Technologies

- Terraform, AWS, Azure, GCP, GitHub Actions, Python 3.12

## How to Deploy

Prerequisites: Terraform >= 1.0, AWS CLI, Azure CLI, Google Cloud CLI

cd into any module folder, then run terraform init, terraform plan, terraform apply
