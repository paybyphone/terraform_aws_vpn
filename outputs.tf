// module terraform_aws_vpn

// The ID of the VPN gateway in use (either existing or newly created).
output "vpn_gateway_id" {
  value = "${var.use_existing_vpn_gateway == "true" ? var.existing_vpn_gateway_id : aws_vpn_gateway.vpn_gateway.id}"
}
