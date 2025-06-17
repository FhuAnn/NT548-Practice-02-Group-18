terraform {
  backend "s3" {
    bucket         = "lab02-terraform-state-group18"
    key            = "iam/terraform.tfstate"
    region         = "ap-southeast-1"
    use_lockfile = true
  }
}

provider "aws" {
  region = var.region
}

resource "aws_iam_role" "ec2_role" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "secrets_manager_policy" {
  name        = "${var.role_name}-secrets-manager-policy"
  description = "IAM policy to allow access to AWS Secrets Manager"

  policy = data.aws_iam_policy_document.secrets_manager_policy.json
}

data "aws_iam_policy_document" "secrets_manager_policy" {
  statement {
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
    resources = var.secret_arns
  }
}

resource "aws_iam_role_policy_attachment" "attach_secrets_manager_policy" {
  policy_arn = aws_iam_policy.secrets_manager_policy.arn
  role       = aws_iam_role.ec2_role.name
}

# Create an IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.role_name}-instance-profile"
  role = aws_iam_role.ec2_role.name
}


#trivy fix - Create an IAM Role for VPC Flow Logs
resource "aws_iam_policy" "custom_vpc_flow_logs_policy" {
  name        = "CustomVPCFlowLogsPolicy"
  description = "Custom policy for VPC Flow Logs to write to CloudWatch Logs"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "vpc_flow_logs_policy" {
  role       = aws_iam_role.vpc_flow_logs_role.name
  policy_arn = aws_iam_policy.custom_vpc_flow_logs_policy.arn
}