data "archive_file" "lambda" {
  type        = "zip"
  source_file = "main.py"
  output_path = "main.py.zip"
}
data "archive_file" "lambda2" {
  type        = "zip"
  source_file = "main2.py"
  output_path = "main2.py.zip"
}

resource "aws_lambda_function" "python_lambda" {
  filename         = "main.py.zip"
  function_name    = "POC_Lambda-1"
  role             = aws_iam_role.role1.arn
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime          = "python3.9"
  handler          = "main.lambda_handler"
}

resource "aws_lambda_function" "python_lambda2" {
  filename         = "main2.py.zip"
  function_name    = "POC_Lambda-2"
  role             = aws_iam_role.role2.arn
  source_code_hash = data.archive_file.lambda2.output_base64sha256
  runtime          = "python3.9"
  handler          = "main2.lambda_handler"
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = aws_sqs_queue.standard_queue.arn
  function_name    = aws_lambda_function.python_lambda.arn
}

resource "aws_lambda_event_source_mapping" "dynamo_trigger" {
  event_source_arn  = aws_dynamodb_table.dynamodb-table.stream_arn
  function_name     = aws_lambda_function.python_lambda2.arn
  starting_position = "LATEST"
}