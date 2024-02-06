module "me_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "me"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/me"
    }
  }
}

module "favorite" {
  source    = "./favorite"
  parent_id = module.me_resources.resource_id
  args      = var.args
}

module "follow" {
  source    = "./follow"
  parent_id = module.me_resources.resource_id
  args      = var.args
}

module "history" {
  source    = "./history"
  parent_id = module.me_resources.resource_id
  args      = var.args
}

module "identity" {
  source    = "./identity"
  parent_id = module.me_resources.resource_id
  args      = var.args
}

module "info" {
  source    = "./info"
  parent_id = module.me_resources.resource_id
  args      = var.args
}

module "new-user-promotion" {
  source    = "./new-user-promotion"
  parent_id = module.me_resources.resource_id
  args      = var.args
}

module "news" {
  source    = "./news"
  parent_id = module.me_resources.resource_id
  args      = var.args
}

module "password" {
  source    = "./password"
  parent_id = module.me_resources.resource_id
  args      = var.args
}

module "products" {
  source    = "./products"
  parent_id = module.me_resources.resource_id
  args      = var.args
}

module "requests" {
  source    = "./requests"
  parent_id = module.me_resources.resource_id
  args      = var.args
}

module "scrap" {
  source    = "./scrap"
  parent_id = module.me_resources.resource_id
  args      = var.args
}

module "status" {
  source    = "./status"
  parent_id = module.me_resources.resource_id
  args      = var.args
}


module "stats" {
  source    = "./stats"
  parent_id = module.me_resources.resource_id
  args      = var.args
}
