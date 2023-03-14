module "alb" {
  source  = "../modules/ALB"
  #version = "~> 8.0"

  name = "my-alb"

  load_balancer_type = "application"

  vpc_id             = "vpc-0f8d38a8b154f640d"
  subnets            = ["subnet-0bb3ecd735a4f31f3", "subnet-0d89fee5417872a8f"]
  security_groups    = ["sg-0582bcaad6341ae00", "sg-07f2d5608f8c7e947"]

  access_logs = {
    bucket = "my-alb-logs"
  }

  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
  #     targets = {
  #       my_target = {
  #         target_id = "arn:aws:elasticloadbalancing:us-east-1:308393840560:targetgroup/pref-20230310190939889100000002/ee28a4c88648e0c6"
  #         port = 80
  #       }
  #       my_other_target = {
  #         target_id = ""
  #         port = 8080
  #       }
  #     }
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = "arn:aws:acm:us-east-1:308393840560:certificate/9b1df333-a6ea-4c30-9c92-2df2a5d77d7e"
      target_group_index = 0
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "Dev"
  }
}