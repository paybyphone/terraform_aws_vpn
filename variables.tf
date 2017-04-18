// module terraform_aws_vpn

// The path of the project in VCS.
variable "project_path" {
  type = "string"
}

// The VPC ID.
variable "vpc_id" {
  type = "string"
}

// The ID of an existing VPN gateway. If this is specified, a new VPN gateway
// is not created. Use this when you need to create another set of VPN
// connections to a different set of remote subnets, as AWS only allows one VPN
// gateway per VPC.
variable "existing_vpn_gateway_id" {
  type    = "string"
  default = ""
}

// The IP addresses of the VPN endpoints that you want to connect to.
variable "vpn_ip_addresses" {
  type = "list"
}

// The remote network addresses to VPN to.
variable "remote_network_addresses" {
  type = "list"
}

// The number of route tables supplied to private_route_table_ids. This needs
// to be an exact match, or there will be an error. This parameter needs to
// be present due to current limitations in Terraform and may be removed in
// later releases.
variable "private_route_table_count" {
  type = "string"
}

// The route table IDs of the private network to connect with the VPN.
variable "private_route_table_ids" {
  type = "list"
}

// The AS number of the remote network.
variable "remote_asn" {
  type    = "string"
  default = "65000"
}
