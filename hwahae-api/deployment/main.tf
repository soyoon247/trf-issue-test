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

resource "aws_api_gateway_deployment" "release_1_5" {
  rest_api_id = var.rest_api_id
  description = "1.5 - Commerce Webview api gateway 통합, 모듈 버전 변경(1.0.6), models 사용 제거"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_1_6" {
  rest_api_id = var.rest_api_id
  description = "1.6 - SV-뷰티온 댓글 조회(GET) API 추가"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_2_0" {
  rest_api_id = var.rest_api_id
  description = "2.0 - GET users/me/stats, GET commerce/users/me/stats 추가"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_2_1" {
  rest_api_id = var.rest_api_id
  description = "2.1 - awards 하위 api의 권한부여자를 hwahae_auth_authorizer로 변경"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_2_2" {
  rest_api_id = var.rest_api_id
  description = "2.2 - users/me/stats GET authorizer 추가"

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_api_gateway_deployment" "release_2_3" {
  rest_api_id = var.rest_api_id
  description = "2.3 - awards 하위 api의 권한부여자를 hwahae_auth_authorizer로 변경 작업 수정"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_2_4" {
  rest_api_id = var.rest_api_id
  description = "2.4 - cart-count api의 권한부여자를 hwahae_auth_authorizer로 변경"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_2_5" {
  rest_api_id = var.rest_api_id
  description = "2.5 - 모든 api의 권한부여자를 hwahae_auth_authorizer로 변경"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_3_0" {
  rest_api_id = var.rest_api_id
  description = "3.0 - recommendations 하위 리소스 추가"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_4_0" {
  rest_api_id = var.rest_api_id
  description = "4.0 - auth/signin, auth/signup, auth/token/refresh OPTIONS 추가"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_4_1" {
  rest_api_id = var.rest_api_id
  description = "4.1 - rankings 하위 api의 authorizer 변경"

  lifecycle {
    create_before_destroy = true
  }
}
