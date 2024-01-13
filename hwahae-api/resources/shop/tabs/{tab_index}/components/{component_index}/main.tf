module "component_index_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{component_index}"

  method_values = {
    GET = {
      method_request_parameters = {
        "method.request.path.component_index"      = "true"
        "method.request.path.tab_index"            = "true"
        "method.request.querystring.keyword_index" = "false"
      }
      method_response_map = {
        200 = {}
        404 = {}
        500 = {}
      }
      integration_request_parameters = {
        "integration.request.path.component_index" = "method.request.path.component_index"
        "integration.request.path.tab_index"       = "method.request.path.tab_index"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/shop/tabs/{tab_index}/components/{component_index}"
    }
  }
}
