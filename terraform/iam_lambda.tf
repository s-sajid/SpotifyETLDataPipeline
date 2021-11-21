resource "aws_iam_role" "lambda_execution_role"{
    name = "lambda_execution_role"
    assume_role_policy = data.aws_iam_policy_document.lambda_trust_policy.json
}

data "aws_iam_policy_document" "lambda_trust_policy" {
    statement {
        effect = "Allow"

        principals {
            type = "Service"
            identifiers = [
                "lambda.amazonaws.com",
                "ec2.amazonaws.com"
            ]
        }
        actions = ["sts:AssumeRole"]
    }
}

resource "aws_iam_policy" "lambda_execution_policy" {
  name = "lambda_execution_policy"
  policy = data.aws_iam_policy_document.lambda_execution_policy_document.json
}

data "aws_iam_policy_document" "lambda_execution_policy_document" {
    statement {
        sid = "ManageLambdaFunction"
        effect = "Allow"

        actions = [
            "lambda:*",
            "ec2:*",
            "cloudwatch:*",
            "logs:*",
            "s3:*"
        ]

        resources = ["*"]
    }
}