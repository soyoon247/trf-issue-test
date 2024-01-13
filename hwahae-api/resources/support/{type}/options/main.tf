module "options_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "options"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.path.type" = "true"
      }
      method_response_map = {
        200 = { response_models = var.args.response_models_empty }
      }

      integration_request_parameters = {
        "integration.request.path.type" = "method.request.path.type"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/support/{type}/options"
    }
  }
}
