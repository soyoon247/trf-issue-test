module "brands_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "brands"

  method_values = {
    DELETE = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.temp_hwahae_authorizer
      method_response_map = {
        200 = { response_models = var.args.empty_response_models }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/users/me/favorite/brands"
    }

    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.temp_hwahae_authorizer
      method_response_map = {
        200 = { response_models = var.args.empty_response_models }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/users/me/favorite/brands"
    }

    POST = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.temp_hwahae_authorizer
      method_response_map = {
        200 = { response_models = var.args.empty_response_models }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/users/me/favorite/brands"
    }

    OPTIONS = {
      integration_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Headers" = var.args.cors_allowed_headers
            "method.response.header.Access-Control-Allow-Methods" = var.args.all_methods
            "method.response.header.Access-Control-Allow-Origin"  = var.args.all_origin
          }
        }
      }
    }
  }
}
