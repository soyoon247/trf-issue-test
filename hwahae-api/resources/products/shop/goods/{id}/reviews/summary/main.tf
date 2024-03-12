module "summary_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "summary"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.header.hwahae-device-scale"     = "false"
        "method.request.header.hwahae-user-id"          = "false"
        "method.request.path.id"                        = "true"
        "method.request.querystring.encryptedProductId" = "false"
      }
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
        }
        500 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
        }
      }
      integration_request_parameters = {
        "integration.request.header.hwahae-device-scale"     = "method.request.header.hwahae-device-scale"
        "integration.request.header.hwahae-user-id"          = "method.request.header.hwahae-user-id"
        "integration.request.path.id"                        = "method.request.path.id"
        "integration.request.querystring.encryptedProductId" = "method.request.path.encryptedProductId"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_JSP}/HwaHae3.0/Search/GoodsReviewCardInfoGetter.jsp"
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = var.args.all_origin
          }
          500 = {
            response_parameters = {
              "method.response.header.Access-Control-Allow-Origin" = var.args.all_origin
            }
            selection_pattern = "500"
          }
        }
      }
    }

    OPTIONS = {
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "false"
            "method.response.header.Access-Control-Allow-Methods" = "false"
            "method.response.header.Access-Control-Allow-Origin"  = "false"
          }
        }
      }
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,hwahae-device-scale,hwahae-user-id'"
            "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }
    }
  }
}
