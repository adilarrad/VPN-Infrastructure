#---------------------------------------------------
#POLICIES
#---------------------------------------------------

resource "aws_iam_policy" "s3-access-policy" {
  name        = "s3-access-policy"
  description = "Allow EC2 instances to upload, download, list, and delete objects in the S3 buckets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = [
          "${var.ansible-bucket-arn}",
          "${var.wireguard-bucket-arn}"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "${var.ansible-bucket-arn}/*",
          "${var.wireguard-bucket-arn}/*"
        ]
      }
    ]
  })

  tags = {
    Name = "s3-access-buckets"
  }
}

#---------------------------------------------------
#ROLES
#---------------------------------------------------

resource "aws_iam_role" "ec2-role" {
  name = "ec2-s3-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "EC2 Role"
  }
}

#-----------------------------------------------
#ATTACH POLICY TO ROLE
#-----------------------------------------------

resource "aws_iam_role_policy_attachment" "attach-policy" {
  role       = aws_iam_role.ec2-role.name
  policy_arn = aws_iam_policy.s3-access-policy.arn
}

#--------------------------------------------------
#INSTANCE PROFILE
#--------------------------------------------------

resource "aws_iam_instance_profile" "ec2-instance-profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2-role.name

  tags = {
    Name = "Instance Profile"
  }
}