resource "aws_api_gateway_rest_api" "myapi" {
  name        = var.rest_api_name
  description = "Hello Rest API deployed through Terraform"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "myapiRootResource" {
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  parent_id   = aws_api_gateway_rest_api.myapi.root_resource_id
  path_part   = "hello"
}

resource "aws_api_gateway_resource" "myapiProxyResource" {
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  parent_id   = aws_api_gateway_resource.myapiRootResource.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "myapiMethod" {
  rest_api_id   = aws_api_gateway_rest_api.myapi.id
  resource_id   = aws_api_gateway_resource.myapiProxyResource.id
  http_method   = "ANY"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

# resource "aws_api_gateway_method_response" "myapiMethodResponse" {
#   rest_api_id = aws_api_gateway_rest_api.myapi.id
#   resource_id = aws_api_gateway_resource.myapiProxyResource.id
#   http_method = aws_api_gateway_method.myapiMethod.http_method
#   status_code = 200
# }

# resource "aws_api_gateway_integration_response" "myapiIntegrationResponse" {
#   rest_api_id = aws_api_gateway_rest_api.myapi.id
#   resource_id = aws_api_gateway_resource.myapiProxyResource.id
#   http_method = aws_api_gateway_method.myapiMethod.http_method
#   status_code = aws_api_gateway_method_response.myapiMethodResponse.status_code
# }

resource "aws_api_gateway_integration" "myapiIntegration" {
  rest_api_id             = aws_api_gateway_rest_api.myapi.id
  resource_id             = aws_api_gateway_resource.myapiProxyResource.id
  http_method             = aws_api_gateway_method.myapiMethod.http_method
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "https://www.bbc.com/{proxy}"

  # passthrough_behavior = "WHEN_NO_MATCH"
  # content_handling     = "CONVERT_TO_TEXT"

  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }

}


resource "aws_api_gateway_deployment" "apiDeployment" {
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_integration.myapiIntegration.id,
    ]))
  }
  lifecycle {
    create_before_destroy = true
  }
}
