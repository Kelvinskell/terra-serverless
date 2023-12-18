resource "aws_lambda_function" "test_lambda" {
  filename      = "lambda_function_payload.zip"
  function_name = "POC_Lambda-1"
  role          = aws_iam_role.role1.arn
  runtime = "python3.9"
}