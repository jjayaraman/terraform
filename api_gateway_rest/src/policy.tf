resource "aws_api_gateway_rest_api_policy" "biztalkPolicy" {
  rest_api_id = aws_api_gateway_rest_api.biztalk.id
  policy      = <<EOT
  {
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Deny",
        "Principal" : "*",
        "Action" : "execute-api:Invoke",
        "Resource" : "*"
      }
    ]
  }
  EOT
}
