module "brands_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "brands"

  common_values = {
    authorization = var.args.authorization.CUSTOM
    authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
    method_response_map = {
      200 = { response_models = var.args.empty_response_models }
    }
    integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/users/me/favorite/brands"
  }
  method_values = {
    DELETE = {}
    GET    = {}
    POST   = {}
  }
}
