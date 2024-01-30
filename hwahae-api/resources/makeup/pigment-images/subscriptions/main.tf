module "subscriptions_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "subscriptions"

  common_values = {
    authorization       = var.args.authorization.CUSTOM
    authorizer_id       = var.args.hwahae_authorizer_id_map.hwahae_authorizer
    method_response_map = {}
    integration_uri     = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/makeup/pigment-images/subscriptions"
  }
  method_values = {
    GET  = {}
    POST = {}
  }
}

