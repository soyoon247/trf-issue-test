module "proxy_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{proxy+}"

  method_values = {
    ANY = {
      authorization   = var.args.authorization.CUSTOM
      authorizer_id   = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      integration_uri = "http://$${stageVariables.AD_SERVING_SERVER_API_ALB}/{proxy}"
    }
  }
}


