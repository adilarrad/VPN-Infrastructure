resource "aws_s3_bucket" "ansible-bucket" {
  bucket = "ansible-bucket-${random_id.suffix.hex}"
  force_destroy = true  


  tags = {
    Name        = "Ansible bucket"
  }
}

resource "aws_s3_bucket" "wireguard-bucket" {
  bucket = "wireguard-bucket-${random_id.suffix.hex}"
  force_destroy = true  


  tags = {
    Name        = "WireGuard bucket"
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}