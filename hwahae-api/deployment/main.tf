# TODO 롤백 가능성이 없는 deployment 삭제 (센터)

resource "aws_api_gateway_deployment" "version_0_0" {
  rest_api_id = var.rest_api_id
  description = "0.0 - /example 리소스 생성"

  lifecycle {
    create_before_destroy = true
  }
}
