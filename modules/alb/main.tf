resource "aws_lb" "application_load_balancer" {
  name                       = var.alb_name
  internal                   = false
  load_balancer_type         = var.load_balancer_type
  security_groups            = var.security_group_id
  subnets                    = var.subnet_ids
  enable_deletion_protection = var.enable_deletion_protection
  tags = {
    Name = var.alb_name
  }
}

resource "aws_lb_target_group" "asg_tg" {
  name     = var.alb_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  # target_type = "ip"

  health_check {
    path                = var.health_check_path
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.alb_name}"
  }
}

resource "aws_lb_listener" "asg_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg_tg.arn
  }
}

