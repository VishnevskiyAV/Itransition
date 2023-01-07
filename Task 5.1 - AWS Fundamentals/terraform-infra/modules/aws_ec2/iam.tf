# ___________________________________________________
# Terraform
#
# Provisioning:
#   - IAM Role for EC2 & IAM Instance Profile
# ___________________________________________________

# IAM Role for EC2 & IAM Instance Profile
data "aws_iam_policy_document" "ec2_service_policy" {
  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]
  }
}

resource "aws_iam_role" "ec2_service" {
  name = "${var.env}-EC2Role"
  path = "/"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Action" : "sts:AssumeRole",
          "Principal" : {
            "Service" : "ec2.amazonaws.com"
          },
          "Effect" : "Allow"
        }
      ]
    }
  )
}

resource "aws_iam_role_policy" "ecs_service" {
  name   = "${var.env}-ECSRole-Policy"
  policy = data.aws_iam_policy_document.ec2_service_policy.json
  role   = aws_iam_role.ec2_service.id
}

resource "aws_iam_instance_profile" "ec2_service_instance_profile" {
  path = "/"
  name = "${var.env}-ec2-instace-profile"
  role = aws_iam_role.ec2_service.name
}


