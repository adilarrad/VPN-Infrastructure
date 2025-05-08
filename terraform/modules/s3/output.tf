output "ansible-bucket-arn" {
    value = aws_s3_bucket.ansible-bucket.arn
}

output "wireguard-bucket-arn" {
    value = aws_s3_bucket.wireguard-bucket.arn
}