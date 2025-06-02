data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

resource "aws_launch_configuration" "asg_lt" {
  name_prefix     = "asg-template-"
  image_id        = data.aws_ami.amazon_linux_2.id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = var.security_group_ids

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from ASG instance $(hostname -f)</h1>" > /var/www/html/index.html
              EOF
  )
  lifecycle {
    create_before_destroy = true
  }
}



resource "aws_autoscaling_group" "example_asg" {
  name_prefix          = "example-asg-"
  max_size             = var.max_size
  min_size             = var.min_size
  desired_capacity     = var.desired_capacity
  vpc_zone_identifier  = var.subnet_ids
  launch_configuration = aws_launch_configuration.asg_lt.name

  health_check_type         = "ELB"
  health_check_grace_period = 300

  # Load balancing arn
  target_group_arns = var.target_group_arns
  tag {
    key                 = "Name"
    value               = "ASG-Instance"
    propagate_at_launch = true
  }
}

