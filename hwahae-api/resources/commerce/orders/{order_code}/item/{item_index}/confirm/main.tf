module "confirm_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "confirm"

  method_values = {
    OPTIONS = {
      method_request_parameters = {
        "method.request.path.item_index" = "true"
        "method.request.path.order_code" = "true"
      }
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "'Origin, Authorization, Content-Type, Content-Range, Content-Disposition, Content-Description, X-Requested-With, X-ACCESS_TOKEN, X-Amz-Date, X-Api-Key, X-Amz-Security-Token, Hwahae-User-Id, Hwahae-App-Version, Hwahae-Device-Scale, Hwahae-Timestamp, Hwahae-Platform, Hwahae-Signature, Hwahae-Device-Id'"
            "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,PATCH'"
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }
    }

    PATCH = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.path.item_index" = "true"
        "method.request.path.order_code" = "true"
      }
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
          response_models = var.args.empty_response_models
        }
      }
      integration_request_parameters = {
        "integration.request.path.item_index" = "method.request.path.item_index"
        "integration.request.path.order_code" = "method.request.path.order_code"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_COMMERCE_SERVER}/orders/{order_code}/item/{item_index}/confirm"
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = var.args.all_origin
          }
        }
      }
    }
  }
}

