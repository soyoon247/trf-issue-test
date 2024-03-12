module "goods_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "goods"
  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.querystring.except_goods_index" = "false"
        "method.request.querystring.filter_type"        = "false"
        "method.request.querystring.group_goods_index"  = "false"
        "method.request.querystring.limit"              = "false"
        "method.request.querystring.offset"             = "false"
      }
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "false"
            "method.response.header.Access-Control-Allow-Origin"  = "false"
          }
          response_models = var.args.empty_response_models
        }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_COMMERCE_SERVER}/goods"
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = var.args.all_origin
          }
        }
      }
    }

    OPTIONS = {
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "'Origin, Authorization, Content-Type, Content-Range, Content-Disposition, Content-Description, X-Requested-With, X-ACCESS_TOKEN, X-Amz-Date, X-Api-Key, X-Amz-Security-Token, Hwahae-User-Id, Hwahae-App-Version, Hwahae-Device-Scale, Hwahae-Timestamp, Hwahae-Platform, Hwahae-Signature, Hwahae-Device-Id'"
            "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }
    }
  }
}

module "filter-partner" {
  source    = "./filter-partner"
  parent_id = module.goods_resources.resource_id
  args      = var.args
}

module "goods_index" {
  source    = "./{goods_index}"
  parent_id = module.goods_resources.resource_id
  args      = var.args
}

module "trends" {
  source    = "./trends"
  parent_id = module.goods_resources.resource_id
  args      = var.args
}

module "filter-category" {
  source    = "./filter-category"
  parent_id = module.goods_resources.resource_id
  args      = var.args
}
