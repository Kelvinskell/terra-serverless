# Create API gateway
resource "aws_api_gateway_rest_api" "apigw" {
  name = "POC-API"
}

# Cretae method
resource "aws_api_gateway_method" "apigw_method" {
  authorization = "NONE"
  http_method   = "POST"
  resource_id   = aws_api_gateway_rest_api.apigw.root_resource_id
  rest_api_id   = aws_api_gateway_rest_api.apigw.id
}

# Create request integration
resource "aws_api_gateway_integration" "apigw_integration" {
  integration_http_method = "POST"
  http_method             = aws_api_gateway_method.apigw_method.http_method
  resource_id             = aws_api_gateway_rest_api.apigw.root_resource_id
  rest_api_id             = aws_api_gateway_rest_api.apigw.id
  type                    = "AWS"
  credentials             = aws_iam_role.api.arn
  uri                     = "arn:aws:apigateway:us-east-1:sqs:path/${aws_sqs_queue.standard_queue.name}"

  request_parameters = {
    "integration.request.header.Content-Type" = "'application/x-www-form-urlencoded'"
  }

  request_templates = {
    "application/json" = "Action=SendMessage&MessageBody=$input.body"
  }
}

# Deploy API
resource "aws_api_gateway_deployment" "apigw_deploy" {
  rest_api_id = aws_api_gateway_rest_api.apigw.id
  stage_name  = "dev"

  depends_on = [
    aws_api_gateway_integration.apigw_integration
  ]
}