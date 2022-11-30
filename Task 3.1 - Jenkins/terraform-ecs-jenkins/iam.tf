# ___________________________________________________
# Terraform
#
# Provisioning:
#   - IAM Role for ECS & IAM Instance Profile
# 
# Made by Aleksandr Vishnevskiy
# ___________________________________________________

# IAM Role for ECS & IAM Instance Profile
data "aws_iam_policy_document" "ecs_service_policy" {
  statement {
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "ecs:CreateCluster",
      "ecs:DeregisterContainerInstance",
      "ecs:DiscoverPollEndpoint",
      "ecs:Poll",
      "ecs:RegisterContainerInstance",
      "ecs:StartTelemetrySession",
      "ecs:Submit*",
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetAuthorizationToken",
      "ecs:UpdateContainerInstancesState",
      "elasticfilesystem:DescribeAccessPoints",
      "elasticfilesystem:DescribeFileSystems",
      "elasticfilesystem:DescribeMountTargets",
      "ec2:DescribeAvailabilityZones",
    ]
  }
}

resource "aws_iam_role" "ecs_service_role" {
  name                = "${var.env}-ECS-service-role"
  path                = "/"
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"]
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

resource "aws_iam_role_policy" "ecs_service_policy" {
  name   = "${var.env}-ECS-service-policy"
  policy = data.aws_iam_policy_document.ecs_service_policy.json
  role   = aws_iam_role.ecs_service_role.id
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  path = "/"
  name = "${var.env}-ecs-instace-profile"
  role = aws_iam_role.ecs_service_role.name
}



