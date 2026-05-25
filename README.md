# terraform-multicloud

Infrastructure-as-Code portfolio provisioning resources across AWS and Azure using Terraform, with a GitHub Actions CI/CD pipeline.

## Overview

This portfolio demonstrates real multi-cloud infrastructure across AWS, Azure, and GCP, provisioned entirely through Terraform and secured using IAM access keys with least-privilege permissions. Every project is designed to minimize cost — using free tier instances, serverless compute that only charges on execution, and resources that can be fully destroyed in seconds when not in use. A GitHub Actions CI/CD pipeline automatically validates all Terraform configs on every push, catching errors before they ever reach real infrastructure. Along the way this project worked through real-world cloud challenges including region capacity restrictions, VM SKU availability issues, and provider version conflicts — the same problems you'd encounter in a production environment.

## Projects

- ec2-nginx - AWS EC2 t3.micro running nginx with security group
- azure-nginx - Azure Ubuntu 22.04 ARM64 VM running nginx with VNet and NSG
- aws-lambda-api - Serverless API using Lambda and API Gateway returning JSON
- gcp-nginx - GCP e2-micro Compute Engine VM running nginx with firewall rules

## Technologies

- Terraform, AWS, Azure, GCP, GitHub Actions, Python 3.12

## How to Deploy

Prerequisites: Terraform >= 1.0, AWS CLI, Azure CLI, Google Cloud CLI

cd into any module folder, then run terraform init, terraform plan, terraform apply
