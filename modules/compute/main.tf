resource "aws_launch_template" "asg_lt" {
  name_prefix   = "asg-template-"
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.security_group_ids
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ASG-Instance"
    }
  }

  user_data = base64encode(<<-EOF
            #!/bin/bash 
            yum update -y 
            yum install -y httpd 
            systemctl start httpd 
            systemctl enable httpd 
            echo "<h1>Hello from ASG instance $(hostname -f)</h1>" > /var/www/html/index.html   
            EOF  
  )
}

data "aws_ami" "amazon_linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

resource "aws_autoscalling_group" "example_asg" {
  name_prefix         = "example-asg-"
  vpc_zone_identifier = var.subnet_ids
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size

  launch_template {
    id      = aws_launch_template.asg_lt.id
    version = "$Latest"
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300

  target_group_arns = var.target_group_arns

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "ASG-Instance"
    propagate_at_launch = true
  }
}

