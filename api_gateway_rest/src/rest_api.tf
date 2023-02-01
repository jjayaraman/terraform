resource "aws_api_gateway_rest_api" "myapi" {

  name = var.rest_api_name
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}




resource "aws_api_gateway_deployment" "apiDeployment" {
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_rest_api.myapi.id,
    ]))
  }
  lifecycle {
    create_before_destroy = true
  }
}
