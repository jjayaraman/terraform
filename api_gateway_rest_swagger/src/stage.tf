
resource "aws_api_gateway_stage" "biztalk" {
  deployment_id = aws_api_gateway_deployment.biztalk.id
  rest_api_id   = aws_api_gateway_rest_api.biztalk.id
  stage_name    = var.stage_name
}


resource "aws_api_gateway_method_settings" "all" {

  stage_name  = aws_api_gateway_stage.biztalk.stage_name
  rest_api_id = aws_api_gateway_rest_api.biztalk.id
  method_path = "*/*"

  settings {
    metrics_enabled = true
    caching_enabled = false
  }

}
