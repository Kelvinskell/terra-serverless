resource "aws_lambda_function" "python_lambda" {
  filename      = "main.py.zip"
  function_name = "POC_Lambda-1"
  role          = aws_iam_role.role1.arn
  runtime = "python3.9"
  handler = "main.py.zip"
}

resource "aws_lambda_event_source_mapping" "example" {
  event_source_arn = aws_sqs_queue.standard_queue.arn
  function_name    = aws_lambda_function.python_lambda.arn
}