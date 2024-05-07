module "comment_id_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{comment_id}"

  method_values = {
    DELETE = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.temp_hwahae_authorizer
      method_request_parameters = {
        "method.request.path.comment_id"  = "true"
        "method.request.path.beautyon_id" = "true"
      }
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }
      integration_request_parameters = {
        "integration.request.path.comment_id"  = "method.request.path.comment_id"
        "integration.request.path.beautyon_id" = "method.request.path.beautyon_id"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/beautyon/{beautyon_id}/comments/{comment_id}"
    }
  }
}

module "report" {
  source    = "./report"
  parent_id = module.comment_id_resources.resource_id
  args      = var.args
}


