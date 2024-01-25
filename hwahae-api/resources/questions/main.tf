module "questions_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "questions"

  method_values = {
    POST = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.header.hwahae-user-id" = "true"
      }
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
        400 = {}
      }
      integration_request_parameters = {
        "integration.request.header.hwahae-user-id" = "method.request.header.hwahae-user-id"
      }
      integration_type = var.args.integration_type.HTTP
      integration_uri  = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/questions"
      integration_response_map = {
        200 = {}
        400 = { selection_pattern = "400" }
      }
    }
  }
}

module "categories" {
  source    = "./categories"
  parent_id = module.questions_resources.resource_id
  args      = var.args
}


