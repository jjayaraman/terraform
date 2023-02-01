resource "aws_api_gateway_rest_api" "biztalk" {
  body = file("./petstore_swager.json")
  name = var.rest_api_name
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "biztalk" {
  rest_api_id = aws_api_gateway_rest_api.biztalk.id
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_rest_api.biztalk.body,
      aws_api_gateway_rest_api_policy.biztalkPolicy.id
    ]))
  }
  lifecycle {
    create_before_destroy = true
  }
}
