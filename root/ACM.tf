module "acm" {
  source  = "../modules/ACM"
  #version = "~> 4.0"

  domain_name  = "www.testnishant.com"
  zone_id      = "Z07818312569NCOXOWZU1"

  subject_alternative_names = [
    "*.www.testnishant.com",
    "app.sub.www.testnishant.com",
  ]

  wait_for_validation = false

  tags = {
    Name = "www.testnishant.com"
  }
}