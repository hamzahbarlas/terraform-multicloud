# terraform-multicloud

Infrastructure-as-Code portfolio provisioning resources across AWS, Azure, and GCP using Terraform, with a GitHub Actions CI/CD pipeline.

## Overview

This portfolio demonstrates real multi-cloud infrastructure across AWS, Azure, and GCP, provisioned entirely through Terraform and secured using IAM access keys with least-privilege permissions. Every project is designed to minimize cost — using free tier instances, serverless compute that only charges on execution, and resources that can be fully destroyed in seconds when not in use. A GitHub Actions CI/CD pipeline automatically validates all Terraform configs on every push, catching errors before they ever reach real infrastructure. Along the way this project worked through real-world cloud challenges including region capacity restrictions, VM SKU availability issues, and provider version conflicts — the same problems you'd encounter in a production environment.

## Projects

- ec2-nginx - AWS EC2 t3.micro running nginx with security group
- azure-nginx - Azure Ubuntu 22.04 ARM64 VM running nginx with VNet and NSG
- aws-lambda-api - Serverless API using Lambda and API Gateway returning JSON
- gcp-nginx - GCP e2-micro Compute Engine VM running nginx with firewall rules

## Security

Security was treated as a first-class concern across every module:

- AWS IAM: A dedicated terraform-user was created with least-privilege permissions instead of using the root account. The Lambda execution role is attached only to AWSLambdaBasicExecutionRole — the minimum required to write logs.
- AWS Security Groups: Inbound rules explicitly allow HTTP on port 80 and SSH on port 22. All other traffic is denied by default.
- Azure NSG: Network Security Group rules allow HTTP and SSH inbound traffic only. SSH authentication uses an auto-generated 4096-bit RSA key pair — no password authentication.
- GCP Firewall: Firewall rules are scoped to instances with a specific network tag (nginx-server) rather than applying to the entire network, limiting blast radius.
- GitHub Actions: AWS credentials are stored as encrypted GitHub Actions secrets and injected at runtime. No credentials are hardcoded anywhere in the codebase.

## Technologies

- Terraform, AWS, Azure, GCP, GitHub Actions, Python 3.12

## How to Deploy

Prerequisites: Terraform >= 1.0, AWS CLI, Azure CLI, Google Cloud CLI

cd into any module folder, then run terraform init, terraform plan, terraform apply
