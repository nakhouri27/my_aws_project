data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source             = "../modules/Networking"
  name               = "EPF-${var.resource_suffix.vpc_suffix}"
  cidr               = "10.2.0.0/16"
  single_nat_gateway = true

  # Get availability_zones from data source
  azs = data.aws_availability_zones.available.names

  # Subnets
  public_subnets   = ["10.2.1.0/24", "10.2.2.0/24"]
  private_subnets  = ["10.2.11.0/24", "10.2.12.0/24"]
  database_subnets = ["10.2.21.0/24", "10.2.22.0/24"]

  # Assigning Subnet Suffix values
  public_subnet_suffix   = "public-subnet"
  private_subnet_suffix  = "private-subnet"
  database_subnet_suffix = "db-subnet"

  # Create route table
  manage_default_route_table = true
  default_route_table_tags   = { DefaultRouteTable = true }

  # Create NACL for vpc
  default_network_acl_name   = "EPF-${var.aws_region}-${var.resource_suffix.nacl_suffix}"
  manage_default_network_acl = true

  # Create NAT gateway for private subnets
  enable_nat_gateway     = true
  one_nat_gateway_per_az = false
  igw_tags           = { "Name" = "EPF-${var.aws_region}-${var.resource_suffix.igw_suffix}" }

  # Disable RDS operation
  create_database_subnet_group = false

   # Enable DNS hostname
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Default Security group rules
  manage_default_security_group   = true
  default_security_group_egress   = [ {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = "0.0.0.0/0"
  }]
  default_security_group_ingress  = [
    {
      description      = "TLS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = "0.0.0.0/0"
    },
    {
      description      = "All inbound allow to VPC"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = "10.2.0.0/16"
    },
    {
      description      = "All inbound allow to same security group"
      protocol         = -1
      self             = true
      from_port        = 0
      to_port          = 0
    }
  ]
}
