#!/bin/bash
# Combined user data script for Apache web server setup with dynamic content

# Update system
yum update -y

# Remove old httpd versions if any
yum -y remove httpd httpd-tools

# Install Apache and PHP
yum install -y httpd php

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

# Add ec2-user to apache group and configure ownership and permissions
usermod -a -G apache ec2-user
chown -R ec2-user:apache /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;

# Go to web root
cd /var/www/html

# Write custom HTML content with hostname and instance-id
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
echo "<h1>Hello from ASG instance $(hostname -f)</h1>" > index.html
echo "<p>Instance ID: $INSTANCE_ID</p>" >> index.html