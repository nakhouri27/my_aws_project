module "ec2" {
  source  = "../modules/EC2"

  for_each = toset(["one", "two", "three"])

  name = "instance-${each.key}"

  ami                    = "ami-05b5badc2f7ddd88d"
  instance_type          = "t2.micro"
  key_name               = "ec2-test"
  monitoring             = true
  vpc_security_group_ids = ["sg-0582bcaad6341ae00"]
  subnet_id              = "subnet-0280405e84b9c1d94"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}