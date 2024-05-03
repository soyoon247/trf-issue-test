module "review_reward_info_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "review-reward-info"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.temp_hwahae_authorizer
      method_request_parameters = {
        "method.request.path.id" = "true"
      }
      method_response_map = {}
      integration_request_parameters = {
        "integration.request.path.id" = "method.request.path.id"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/{id}/review-reward-info"
    }
  }
}


