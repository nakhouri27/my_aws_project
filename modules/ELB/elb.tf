resource "aws_security_group" "alb_sg" {
  name   = "${var.alb_sg_name}-sg-alb-${var.environment}"
  vpc_id = var.vpc_id

  ingress {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
    #cidr_blocks      = formatlist("%s/32", flatten(data.aws_network_interface.nlb_ip.*.private_ips), )
    cidr_blocks      = ["0.0.0.0/0"] #tfsec:ignore:aws-vpc-no-public-ingress-sgr
    ipv6_cidr_blocks = ["::/0"]      #tfsec:ignore:aws-vpc-no-public-ingress-sgr
  }

  ingress {
    protocol         = "tcp"
    from_port        = 443
    to_port          = 443
    cidr_blocks      = ["0.0.0.0/0"] #tfsec:ignore:aws-vpc-no-public-ingress-sgr
    ipv6_cidr_blocks = ["::/0"]      #tfsec:ignore:aws-vpc-no-public-ingress-sgr
  }

  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"] #tfsec:ignore:aws-vpc-no-public-egress-sgr
    ipv6_cidr_blocks = ["::/0"]      #tfsec:ignore:aws-vpc-no-public-egress-sgr
  }
}

resource "aws_lb" "alb" {
  name               = "${var.cluster_name}-${var.environment}-${var.alb_suffix}"
  internal           = var.alb_internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.subnet_id


  enable_deletion_protection = false


  tags = merge(var.common_tags,
    {
      Name = "${var.cluster_name}-${var.environment}-${var.alb_suffix}"
  })

}


# forward to http listener
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  depends_on = [
    aws_lb_listener.alb_listener_https
  ]
}

resource "aws_lb_listener" "alb_listener_https" {
  load_balancer_arn = aws_lb.alb.id
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = var.domain_name_security_policy
  certificate_arn   = var.aws_acm_certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      status_code  = "200"
      content_type = "text/plain"
      message_body = "404 page not found"
    }
  }
}


