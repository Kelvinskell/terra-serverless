# Create IAM Roles
resource "aws_iam_role" "role1" {
  name               = "Lambda-SQS-DynamoDB"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role_lambda.json
  managed_policy_arns = [aws_iam_policy.lambda_dynamo.arn, aws_iam_policy.lambda_sqs.arn]
}

resource "aws_iam_role" "role2" {
  name               = "Lambda-DynamoDBStreams-SNS"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role_lambda.json
  managed_policy_arns = [aws_iam_policy.lambda_dynamostreams.arn, aws_iam_policy.lambda_sns.arn]
}

resource "aws_iam_role" "role3" {
  name               = "APIGateway-SQS"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role_apigw.json

  inline_policy {
    name = "APIGW2CW"

    policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:PutLogEvents",
                "logs:GetLogEvents",
                "logs:FilterLogEvents"
            ],
            "Resource": "*"
        }
    ]
})
  }
}