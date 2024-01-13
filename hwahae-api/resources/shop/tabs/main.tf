module "tabs_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "tabs"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.querystring.selected_tab_index" = "false"
      }
      method_response_map = {
        200 = {}
        404 = {}
        500 = {}
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/shop/tabs"
    }
  }
}

module "tab_index" {
  source    = "./{tab_index}"
  parent_id = module.tabs_resources.resource_id
  args      = var.args
}
