resource "aws_api_gateway_rest_api" "apigw" {
  name = "POC-API"
}

resource "aws_api_gateway_method" "apigw_method" {
  authorization = "NONE"
  http_method   = "POST"
  resource_id   = aws_api_gateway_rest_api.apigw.root_resource_id
  rest_api_id   = aws_api_gateway_rest_api.apigw.id
}

resource "aws_api_gateway_integration" "example" {
  http_method = aws_api_gateway_method.apigw_method.http_method
  resource_id = aws_api_gateway_rest_api.apigw.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.apigw.id
  type        = "AWS"
}