// module terraform_aws_vpn

// The ID of the VPN gateway in use (either existing or newly created).
output "vpn_gateway_id" {
  value = "${var.existing_vpn_gateway_id != "" ? data.aws_vpn_gateway.existing_vpn_gateway.id : aws_vpn_gateway.vpn_gateway.id}"
}
