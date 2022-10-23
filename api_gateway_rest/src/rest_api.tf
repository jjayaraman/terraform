resource "aws_api_gateway_rest_api" "hello" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = var.rest_api_name
      version = "1.0"
    }
    paths = {
      (var.rest_api_path) = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            payLoadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
          }
        }
      }
    }
  })
  name = "hello_api"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}



resource "aws_api_gateway_deployment" "hello" {
  rest_api_id = aws_api_gateway_rest_api.hello.id
  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.hello.body))
  }
}
