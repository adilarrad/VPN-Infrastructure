#------------------------------------------------
#  Ansible Instance  

resource "aws_network_interface" "ansible-interface" {
  subnet_id       = var.subnet-id
  private_ips     = ["10.9.2.50"]
  security_groups = [var.sec-group]

  tags = {
    Name = "Ansible network int"
  }
}

resource "aws_eip" "ansible-eip" {
  domain   = "vpc"
  network_interface = aws_network_interface.ansible-interface.id

  tags = {
    Name = "Ansible Server IP"
  }
}

resource "aws_instance" "ansible-instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  iam_instance_profile = var.instance-profile-name

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.ansible-interface.id
  }


  tags = {
    Name = "Ansible Server"
  }
}


