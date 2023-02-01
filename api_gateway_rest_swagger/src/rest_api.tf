# resource "aws_api_gateway_rest_api" "biztalk" {
#   body = jsonencode({
#     openapi = "3.0.1"
#     info = {
#       title   = var.rest_api_name
#       version = "1.0"
#     }
#     paths = {
#       (var.rest_api_path) = {
#         get = {
#           x-amazon-apigateway-integration = {
#             httpMethod           = "GET"
#             payLoadFormatVersion = "1.0"
#             type                 = "HTTP_PROXY"
#             uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
#           }
#         }
#       }
#     }
#   })
#   name = var.rest_api_name
#   endpoint_configuration {
#     types = ["REGIONAL"]
#   }
# }

# resource "aws_api_gateway_deployment" "biztalk" {
#   rest_api_id = aws_api_gateway_rest_api.biztalk.id
#   triggers = {
#     redeployment = sha1(jsonencode([
#       aws_api_gateway_rest_api.biztalk.body,
#       aws_api_gateway_rest_api_policy.biztalkPolicy.id
#     ]))
#   }
#   lifecycle {
#     create_before_destroy = true
#   }
# }
