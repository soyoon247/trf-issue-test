module "page_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "page"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.path.tab_name" = "true"
      }
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }
      integration_request_parameters = {
        "integration.request.path.tab_name" = "method.request.path.tab_name"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/makeup/tabs/{tab_name}/page"
    }
  }
}

