module "list_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "list"

  method_values = {
    GET = {
      authorization       = var.args.authorization.CUSTOM
      authorizer_id       = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_response_map = {}
      integration_uri     = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/award/list"
    }
  }
}
