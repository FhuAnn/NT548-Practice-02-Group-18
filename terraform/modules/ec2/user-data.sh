#!/bin/bash
# Install AWS CLI (if not already installed)
sudo apt-get update
sudo apt-get install -y awscli

export AWS_DEFAULT_REGION=ap-southeast-1

# Create .ssh directory if it doesn't exist
sudo mkdir -p /home/ubuntu/.ssh

# Set correct permissions for .ssh directory
sudo chmod 700 /home/ubuntu/.ssh

# Retrieve the private key from AWS Secrets Manager
aws secretsmanager get-secret-value --secret-id lab02-keypair-group18 --query 'SecretString' --output text | sed 's/[{}]//g' > /home/ubuntu/.ssh/lab02-keypair-group18.pem

# Set correct permissions for the private key file
sudo chmod 600 /home/ubuntu/.ssh/lab02-keypair-group18.pem

# Ensure ubuntu user owns the .ssh directory and files
sudo chown -R ubuntu:ubuntu /home/ubuntu/.ssh