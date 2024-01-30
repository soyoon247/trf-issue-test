# 콘솔에서 생성한 리소스 정보를 가져오는 data 리소스 추가
data "aws_api_gateway_rest_api" "hwahae_api" {
  name = "Hwahae API"
}

# api 생성 시 필요한 인자를 넘겨주는 locals 추가
locals {
  args = {
    authorization = {
      NONE               = "NONE",
      CUSTOM             = "CUSTOM",
      AWS_IAM            = "AWS_IAM",
      COGNITO_USER_POOLS = "COGNITO_USER_POOLS"
    }

    integration_type = {
      AWS        = "AWS",
      AWS_PROXY  = "AWS_PROXY",
      HTTP       = "HTTP",
      HTTP_PROXY = "HTTP_PROXY",
      MOCK       = "MOCK"
    }

    connection_type = {
      INTERNET = "INTERNET",
      VPC_LINK = "VPC_LINK"
    }

    passthrough_behavior = {
      WHEN_NO_MATCH     = "WHEN_NO_MATCH",
      WHEN_NO_TEMPLATES = "WHEN_NO_TEMPLATES",
      NEVER             = "NEVER"
    }

    empty_response_models = {
      "application/json" = "Empty"
    }

    status_200_request_templates = {
      "application/json" = "{\"statusCode\": 200}"
    }

    option_method_response_parameters = {
      "method.response.header.Access-Control-Allow-Headers" = "false"
      "method.response.header.Access-Control-Allow-Methods" = "false"
      "method.response.header.Access-Control-Allow-Origin"  = "false"
    }

    all_methods = "'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'"

    all_headers = "'*'"

    cors_allowed_headers = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,Hwahae-User-Id,Hwahae-Device-Id,Hwahae-Platform,Hwahae-App-Version,Hwahae-Device-Scale,Hwahae-Timestamp,Hwahae-Signature,User-Agent'"

    all_origin = "'*'"

    rest_api_id = data.aws_api_gateway_rest_api.hwahae_api.id

    root_resource_id = data.aws_api_gateway_rest_api.hwahae_api.root_resource_id

    hwahae_authorizer_id_map = {
      hwahae_authorizer      = "ltd1vj"
      hwahae_auth_authorizer = "tv0y4v"
    }
  }
}

