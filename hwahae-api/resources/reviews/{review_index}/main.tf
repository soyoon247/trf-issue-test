module "review_index_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{review_index}"
  common_values = {
    authorization = var.args.authorization.CUSTOM
    authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
  }
  method_values = {
    DELETE = {
      method_request_parameters = {
        "method.request.path.review_index" = "true"
      }
      method_response_map = {
        200 = { response_models = var.args.empty_response_models }
      }
      integration_request_parameters = {
        "integration.request.path.review_index" = "method.request.path.review_index"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/reviews/{review_index}"
    }

    GET = {
      method_request_parameters = {
        "method.request.header.hwahae-device-scale"   = "true"
        "method.request.header.hwahae-legacy-request" = "false"
        "method.request.header.hwahae-platform"       = "false"
        "method.request.header.hwahae-user-id"        = "false"
        "method.request.path.review_index"            = "true"
        "method.request.querystring.keywordIndex"     = "false"
        "method.request.querystring.keyword_index"    = "false"
        "method.request.querystring.readFromMaster"   = "false"
        "method.request.querystring.read_from_master" = "false"
        "method.request.querystring.userId"           = "false"
        "method.request.querystring.user_id"          = "false"
      }
      method_response_map = {
        200 = {}
        404 = {}
        500 = {}
      }

      request_validator_id             = "x76cy5" # 쿼리 문자열 파라미터 및 헤더 검사
      integration_passthrough_behavior = var.args.passthrough_behavior.WHEN_NO_TEMPLATES
      integration_request_parameters = {
        "integration.request.header.hwahae-device-scale"   = "method.request.header.hwahae-device-scale"
        "integration.request.header.hwahae-legacy-request" = "method.request.header.hwahae-legacy-request"
        "integration.request.header.hwahae-platform"       = "method.request.header.hwahae-platform"
        "integration.request.header.hwahae-user-id"        = "method.request.header.hwahae-user-id"
        "integration.request.path.review_index"            = "method.request.path.review_index"
        "integration.request.querystring.keywordIndex"     = "method.request.querystring.keywordIndex"
        "integration.request.querystring.keyword_index"    = "method.request.querystring.keyword_index"
        "integration.request.querystring.readFromMaster"   = "method.request.querystring.readFromMaster"
        "integration.request.querystring.read_from_master" = "method.request.querystring.read_from_master"
        "integration.request.querystring.reviewId"         = "method.request.path.review_index"
        "integration.request.querystring.userId"           = "method.request.querystring.userId"
        "integration.request.querystring.user_id"          = "method.request.querystring.user_id"
      }

      integration_request_templates = {
        "application/json" = "#set($HwahaeLegacyRequestOverride = \"1\")\n#set($HwahaeLegacyRequest = $input.params('hwahae-legacy-request'))\n$input.json(\"$\")\n#if($HwahaeLegacyRequest == \"\")\n  #set($context.requestOverride.header.hwahae-legacy-request = $HwahaeLegacyRequestOverride)\n#end"
      }

      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/reviews/{review_index}"
      integration_response_map = {
        200 = {}
        404 = { selection_pattern = "404" }
        500 = { selection_pattern = "500" }
      }
    }
    PUT = {
      method_request_parameters = {
        "method.request.path.review_index" = "true"
      }
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }
      integration_request_parameters = {
        "integration.request.path.review_index" = "method.request.path.review_index"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/reviews/{review_index}"
    }
  }
}

module "comments" {
  source    = "./comments"
  parent_id = module.review_index_resources.resource_id
  args      = var.args
}

module "images" {
  source    = "./images"
  parent_id = module.review_index_resources.resource_id
  args      = var.args
}
module "like" {
  source    = "./like"
  parent_id = module.review_index_resources.resource_id
  args      = var.args
}

module "report" {
  source    = "./report"
  parent_id = module.review_index_resources.resource_id
  args      = var.args
}

module "scraps" {
  source    = "./scraps"
  parent_id = module.review_index_resources.resource_id
  args      = var.args
}
