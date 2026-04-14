# Terraform Route53 Lab

This project demonstrates managing DNS records using Terraform.

## Features
- A record
- CNAME record
- MX record
- TXT records using for_each

## Concepts Used
- Data sources
- for_each
- locals
- outputs

## Usage

terraform init  
terraform plan -var="student_name=yourname"  
terraform apply -var="student_name=yourname"