output "wireguard-eip-id" {
  value = aws_eip.wireguard-eip.id
}

output "wireguard-eip-ip" {
    value       = aws_eip.wireguard-eip.public_ip
    description = "The public IP associated to the EC2 instance"
}