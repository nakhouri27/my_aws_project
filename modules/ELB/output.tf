output "alb_id" {
  value = aws_lb.alb.id
}

output "alb_name" {
  value = aws_lb.alb.name
}

output "alb_listener_arn" {
  value = aws_lb_listener.alb_listener.arn
}

output "alb_listener_arn_https" {
  value = aws_lb_listener.alb_listener_https.arn
}

output "aws_alb" {
  value = aws_lb.alb
}

output "alb_url" {
  value = aws_lb.alb.dns_name
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}
