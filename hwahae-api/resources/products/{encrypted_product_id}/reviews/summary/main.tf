module "summary_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "summary"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.header.hwahae-device-scale" = "false"
        "method.request.header.hwahae-user-id"      = "false"
        "method.request.path.encrypted_product_id"  = "true"
        "method.request.querystring.userId"         = "false"
      }
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
        }
        500 = {}
      }
      integration_request_parameters = {
        "integration.request.header.hwahae-device-scale"     = "method.request.header.hwahae-device-scale"
        "integration.request.header.hwahae-user-id"          = "method.request.header.hwahae-user-id"
        "integration.request.querystring.encryptedProductId" = "method.request.path.encrypted_product_id"
        "integration.request.querystring.userId"             = "method.request.querystring.userId"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_JSP}/HwaHae3.0/Search/ProductReviewCardInfoGetter_3.11.jsp"
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = var.args.all_origin
          }
        }
        500 = { selection_pattern = "500" }
      }
    }

    OPTIONS = {
      method_response_map = {
        200 = {}
      }
    }
  }
}

