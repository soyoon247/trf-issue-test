module "rankings_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.8"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "rankings"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/rankings"
    }
  }
}
module "brands" {
  source    = "./brands"
  parent_id = module.rankings_resources.resource_id
  args      = var.args
}

module "home" {
  source    = "./home"
  parent_id = module.rankings_resources.resource_id
  args      = var.args
}

module "products" {
  source    = "./products"
  parent_id = module.rankings_resources.resource_id
  args      = var.args
}

module "rules" {
  source    = "./rules"
  parent_id = module.rankings_resources.resource_id
  args      = var.args
}

module "ranking_id" {
  source    = "./{ranking_id}"
  parent_id = module.rankings_resources.resource_id
  args      = var.args
}


