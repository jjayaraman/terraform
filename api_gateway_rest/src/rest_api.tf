resource "aws_api_gateway_rest_api" "hello" {
  name = "hello_api"
  body = jsonencode({
    openApi = "3.0.1"
    info = {
      title   = var.rest_api_name
      version = "1.0"
    }
    paths = {
      (var.rest_api_path) = {
        get = {
          x-amazon-api-gateway-integration = {
            httpMethod           = "GET"
            payLoadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
          }
        }
      }
    }
  })

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
