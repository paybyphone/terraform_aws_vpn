
# terraform_aws_vpn

This is a Terraform module to create a VPN within an AWS VPC. For more details
on the technology, visit:

http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_VPN.html

This module will set up the VPN gateway, the customer gateway, and all the
routes necessary to connect between the two networks. It does **not** set up
firewall access for you - make sure you have set up any security groups and
network ACLs properly to allow the desired traffic across.

Although the module can be used independently, it is designed for use with
the `terraform_aws_vpc` and `terraform_aws_private_subnet` modules found
here:

https://github.com/paybyphone/terraform_aws_vpc
https://github.com/paybyphone/terraform_aws_private_subnet

Usage example:

    module "vpc" {
      source                  = "github.com/paybyphone/terraform_aws_vpc?ref=VERSION"
      project_path            = "your/project"
      public_subnet_addresses = ["10.0.0.0/26", "10.0.0.64/26"]
      vpc_network_address     = "10.0.0.0/24"
    }

    module "private_subnets" {
      source                            = "github.com/paybyphone/terraform_aws_private_subnet?ref=VERSION"
      nat_gateway_count                 = "2"
      private_subnet_addresses          = ["10.0.0.128/26", "10.0.0.192/26"]
      private_subnet_availability_zones = "${values(module.vpc.public_subnet_availability_zones)}"
      project_path                      = "your/project"
      public_subnet_ids                 = "${keys(module.vpc.public_subnet_availability_zones)}"
      vpc_id                            = "${module.vpc.vpc_id}"
    }

    module "vpn" {
      source                    = "github.com/paybyphone/terraform_aws_vpn?ref=VERSION"
      private_route_table_count = "2"
      private_route_table_ids   = "${module.private_subnets.private_route_table_ids}"
      project_path              = "your/project"
      remote_network_addresses  = ["192.168.0.0/24", "192.168.1.0/24"]
      vpc_id                    = "${module.vpc.vpc_id}"
      vpn_ip_address            = "10.9.8.7"
    }



## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| project_path | The path of the project in VCS. | - | yes |
| vpc_id | The VPC ID. | - | yes |
| vpn_ip_address | The IP address of the VPN endpoint. | - | yes |
| remote_network_addresses | The remote network addresses to VPN to. | - | yes |
| private_route_table_count | The number of route tables supplied to private_route_table_ids. This needs to be an exact match, or there will be an error. This parameter needs to be present due to current limitations in Terraform and may be removed in later releases. | - | yes |
| private_route_table_ids | The route table IDs of the private network to connect with the VPN. | - | yes |
| remote_asn | The AS number of the remote network. | `65000` | no |

