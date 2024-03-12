module "home_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "home"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_COMMERCE_SERVER}/daily-sales/home"
      integration_response_map = {
        200 = {}
      }
    }

    OPTIONS = {
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }
      integration_response_map = {
        200 = {}
      }
    }
  }
}

