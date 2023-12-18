# Create IAM Policies

resource "aws_iam_policy" "lambda_dynamo_sqs_apigw" {
  name        = "Lambda-Write-DynamoDB"
  path        = "/"
  description = "A policy for lambda to put items into DunamoDB"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "dynamodb:PutItem",
          "dynamodb:DescribeTable"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "VisualEditor1",
        "Effect" : "Allow",
        "Action" : [
          "sqs:DeleteMessage",
          "sqs:ReceiveMessage",
          "sqs:GetQueueAttributes",
          "sqs:ChangeMessageVisibility"
        ],
        "Resource" : "*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents",
          "logs:GetLogEvents",
          "logs:FilterLogEvents"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_sns" {
  name        = "Lambda-SNS-Publish"
  path        = "/"
  description = "A policy for Amazon SNS to get, list, and publish topics that are received by Lambda"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "sns:Publish",
          "sns:GetTopicAttributes",
          "sns:ListTopics"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_dynamostreams" {
  name        = "Lambda-DynamoDBStreams-Read"
  path        = "/"
  description = "A policy for Lambda to get records from DynamoDB Streams"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "dynamodb:GetShardIterator",
          "dynamodb:DescribeStream",
          "dynamodb:ListStreams",
          "dynamodb:GetRecords"
        ],
        "Resource" : "*"
      }
    ]
  })
}

# Define policy document
# Create Data Sources

data "aws_iam_policy_document" "assume_role_lambda" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}