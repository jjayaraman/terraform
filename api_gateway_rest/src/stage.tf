
resource "aws_api_gateway_stage" "hello" {
  stage_name    = "dev"
  deployment_id = aws_api_gateway_deployment.hello.id
  rest_api_id   = aws_api_gateway_rest_api.hello.id
}
