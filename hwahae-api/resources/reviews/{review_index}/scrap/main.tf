module "scrap_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "scrap"
  common_values = {
    authorization = var.args.authorization.CUSTOM
    authorizer_id = var.args.hwahae_authorizer_id_map.temp_hwahae_authorizer
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
    integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/reviews/{review_index}/scrap"
  }
  method_values = {
    DELETE = {}
    POST   = {}
  }
}
