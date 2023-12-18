resource "aws_lambda_function" "lambda" {
  filename      = "main.py.zip"
  function_name = "POC_Lambda-1"
  role          = aws_iam_role.role1.arn
  runtime = "python3.9"
  source_code_hash = filebase64sha256("main.py.zip")
  handler = "main.lambda_handler"
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = aws_sqs_queue.standard_queue.arn
  function_name    = aws_lambda_function.lambda.arn
}