resource "aws_api_gateway_deployment" "version_1_0" {
  rest_api_id = var.rest_api_id
  description = "1.0 - 리소스 최종 반영"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_1_1" {
  rest_api_id = var.rest_api_id
  description = "1.1 - /search/reviews, /search/reviews/count, /search/reviews/filters 리소스 추가"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_1_2" {
  rest_api_id = var.rest_api_id
  description = "1.2 - 테스트 a/d/g 리소스 추가"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_1_3" {
  rest_api_id = var.rest_api_id
  description = "1.3 - example 리소스 제거"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_1_4" {
  rest_api_id = var.rest_api_id
  description = "1.4 - 모듈 버전 변경(1.0.4)하여 x-forwarded-for 헤더 적용, POST auth/token/check, POST auth/token/refresh 추가"

  lifecycle {
    create_before_destroy = true
  }
}
