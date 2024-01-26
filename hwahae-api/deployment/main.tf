resource "aws_api_gateway_deployment" "version_1_0" {
  rest_api_id = var.rest_api_id
  description = "1.0 - 리소스 최종 반영"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "version_1_1" {
  rest_api_id = var.rest_api_id
  description = "1.1 - /auth/token/check, auth/token/refresh 리소스 추가"

  lifecycle {
    create_before_destroy = true
  }
}
