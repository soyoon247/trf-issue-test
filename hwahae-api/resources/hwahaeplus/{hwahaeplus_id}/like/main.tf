module "like_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "like"
  common_values = {
    authorization = var.args.authorization.CUSTOM
    authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
    method_request_parameters = {
      "method.request.path.hwahaeplus_id" = "true"
    }
    method_response_map = {
      200 = {
        response_models = var.args.empty_response_models
      }
    }
    integration_request_parameters = {
      "integration.request.path.hwahaeplus_id" = "method.request.path.hwahaeplus_id"
    }
    integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/hwahaeplus/{hwahaeplus_id}/like"
  }
  method_values = {
    DELETE = {}
    GET    = {}
    POST   = {}
  }
}



