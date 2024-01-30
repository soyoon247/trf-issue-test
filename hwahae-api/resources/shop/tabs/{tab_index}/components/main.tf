module "components_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "components"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.path.tab_index" = "true"
      }
      method_response_map = {
        200 = {}
        404 = {}
      }
      integration_request_parameters = {
        "integration.request.path.tab_index" = "method.request.path.tab_index"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/shop/tabs/{tab_index}/components"
    }
  }
}

module "component_index" {
  source    = "./{component_index}"
  parent_id = module.components_resources.resource_id
  args      = var.args
}


