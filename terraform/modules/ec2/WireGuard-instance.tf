#-----------------------------------------------------------------
#  WireGuard Instance  

resource "aws_network_interface" "wireguard-interface" {
  subnet_id       = var.subnet-id
  private_ips     = ["10.9.2.100"]
  security_groups = [var.sec-group]

  tags = {
    Name = "WireGuard network int"
  }
}

resource "aws_instance" "wireguard-instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  iam_instance_profile = var.instance-profile-name #to verify

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.wireguard-interface.id
  }


  tags = {
    Name = "WireGuard Server"
  }
}

resource "aws_eip" "wireguard-eip" {
  domain   = "vpc"
  network_interface = aws_network_interface.wireguard-interface.id

  tags = {
    Name = "WireGuard Server IP"
  }
}