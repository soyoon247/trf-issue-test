module "asks_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "asks"

  method_values = {
    GET = {
      authorization         = var.args.authorization.CUSTOM
      authorizer_id         = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_operation_name = "getQnaBoardList"
      method_request_parameters = {
        "method.request.querystring.goods_index" = "false"
        "method.request.querystring.limit"       = "false"
        "method.request.querystring.offset"      = "false"
        "method.request.querystring.user_index"  = "false"
      }
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
        }
        400 = {
          response_models = {
            "application/json" = "Error"
          }
        }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_COMMERCE_SERVER}/asks"
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = var.args.all_origin
          }
        }
      }
    }

    OPTIONS = {
      method_response_map = {
        200 = {
          response_parameters = var.args.option_method_response_parameters
        }
      }
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

module "ask_index" {
  source    = "./{ask_index}"
  parent_id = module.asks_resources.resource_id
  args      = var.args
}
