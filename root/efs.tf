module "efs" {
  source = "../modules/EFS"

  # File system
  name           = "EPF"
  creation_token = "EPF-token"
  #encrypted      = true
  #kms_key_arn    = "arn:aws:kms:us-east-1:308393840560:key/39ee09b5-44bb-4a37-ae55-c8a744f97c5f"

  performance_mode                = "maxIO"
  throughput_mode                 = "provisioned"
  provisioned_throughput_in_mibps = 256

  lifecycle_policy = {
    transition_to_ia = "AFTER_30_DAYS"
  }

  # File system policy
  attach_policy                      = true
  bypass_policy_lockout_safety_check = false
  policy_statements = [
    {
      sid     = "EPF"
      actions = ["elasticfilesystem:ClientMount"]
      principals = [
        {
          type        = "AWS"
          identifiers = ["arn:aws:iam::308393840560:role/EfsReadOnly"]
        }
      ]
    }
  ]

  # Mount targets / security group
  mount_targets = {
    "us-east-1a" = {
      subnet_id = "subnet-094f23279ddde7099"
    }
    "us-east-1b" = {
      subnet_id = "subnet-0280405e84b9c1d94"
    }
    "us-east-1c" = {
      subnet_id = "subnet-0d89fee5417872a8f"
    }
  }
  security_group_description = "EPF EFS security group"
  security_group_vpc_id      = "vpc-0f8d38a8b154f640d"
  security_group_rules = {
    vpc = {
      # relying on the defaults provdied for EFS/NFS (2049/TCP + ingress)
      description = "NFS ingress from VPC private subnets"
      cidr_blocks = ["172.31.16.0/20", "172.31.32.0/20", "172.31.0.0/20"]
    }
  }

  # Access point(s)
  access_points = {
    posix_example = {
      name = "posix-epf"
      posix_user = {
        gid            = 1001
        uid            = 1001
        secondary_gids = [1002]
      }

      tags = {
        Additionl = "yes"
      }
    }
    root_example = {
      root_directory = {
        path = "/EPF"
        creation_info = {
          owner_gid   = 1001
          owner_uid   = 1001
          permissions = "755"
        }
      }
    }
  }

  # Backup policy
  enable_backup_policy = true

  # Replication configuration
  create_replication_configuration = true
  replication_configuration_destination = {
    region = "us-east-2"
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# resource "aws_efs_file_system" "foo_with_lifecyle_policy" {
#   creation_token = "my-product"

#   lifecycle_policy {
#     transition_to_ia = "AFTER_30_DAYS"
#   }
# }