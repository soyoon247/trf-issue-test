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

resource "aws_api_gateway_deployment" "release_4_2" {
  rest_api_id = var.rest_api_id
  description = "4.2 - product-goods-pair api의 authorizer 변경"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_4_3" {
  rest_api_id = var.rest_api_id
  description = "4.3 - products, search 하위 api의 authorizer 변경"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_5_0" {
  rest_api_id = var.rest_api_id
  description = "5.0 - api 추가 및 수정"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_6_0" {
  rest_api_id = var.rest_api_id
  description = "6.0 - product-goods-pair OPTIONS 변경"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_7_1" {
  rest_api_id = var.rest_api_id
  description = "7.1 - SV-10401, SV-9645, SV-10070, SV-10431, SV-10462, SV-10486, SV-10290"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_8_3" {
  rest_api_id = var.rest_api_id
  description = "8.3 - 모든 api 임시 권한부여자로 변경"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_8_4" {
  rest_api_id = var.rest_api_id
  description = "8.4 - 1차 권한부여자 변경"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_8_5" {
  rest_api_id = var.rest_api_id
  description = "8.5 - 2차 권한부여자 변경"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_deployment" "release_8_6" {
  rest_api_id = var.rest_api_id
  description = "8.6 - 3차 권한부여자 변경 (전체 api)"

  lifecycle {
    create_before_destroy = true
  }
}
