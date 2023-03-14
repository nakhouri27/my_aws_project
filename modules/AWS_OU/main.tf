data "aws_organizations_organization" "aws" {
}

resource "aws_organizations_organizational_unit" "apexon" {
  name      = "Apexon"
  parent_id = data.aws_organizations_organization.aws.roots[0].id

  tags = {
    team      = var.team
    env       = var.env_name
    app       = var.app
    service   = var.service
    sensitive = "no"
  }
}

#AWS Organizations is an account management service that enables us to consolidate multiple AWS accounts into an organization that we create and centrally manage. 
#AWS Organizations includes account management and consolidated billing capabilities that enable us to better meet the budgetary, security, and compliance needs 
#of our business. As an administrator of an organization, we can create accounts in our organization and invite existing accounts to join the organization.