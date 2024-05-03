module "product-goods-pair_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "product-goods-pair"

  method_values = {
    GET = {
      authorization       = var.args.authorization.CUSTOM
      authorizer_id       = var.args.hwahae_authorizer_id_map.hwahae_authorizer_for_any_user
      method_response_map = {}
      integration_uri     = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/product-goods-pair"
    }
    OPTIONS = {
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = var.args.cors_allowed_headers
            "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS'"
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }

        }
      }
    }
  }
}


