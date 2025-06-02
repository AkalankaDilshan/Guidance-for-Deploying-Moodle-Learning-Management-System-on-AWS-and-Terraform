output "alb_dns_name" {
  description = "the DNS name for the ALB"
  value       = aws_lb.application_load_balancer.dns_name
}
output "target_group_arn" {
  description = "The target group arn"
  value       = aws_lb_target_group.asg_tg.arn
}
