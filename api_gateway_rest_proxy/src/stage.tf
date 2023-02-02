
resource "aws_api_gateway_stage" "apiStage" {
  deployment_id = aws_api_gateway_deployment.apiDeployment.id
  rest_api_id   = aws_api_gateway_rest_api.myapi.id
  stage_name    = var.stage_name
}


resource "aws_api_gateway_method_settings" "all" {

  stage_name  = aws_api_gateway_stage.apiStage.stage_name
  rest_api_id = aws_api_gateway_rest_api.myapi.id
  method_path = "*/*"

  settings {
    metrics_enabled = true
    caching_enabled = false
  }

}
