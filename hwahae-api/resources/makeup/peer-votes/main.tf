module "peer-votes_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.4"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "peer-votes"

  method_values = {
    POST = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_response_map = {
        200 = {
          response_models = var.args.empty_response_models
        }
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/makeup/peer-votes"
    }
  }
}

module "candidates" {
  source    = "./candidates"
  parent_id = module.peer-votes_resources.resource_id
  args      = var.args
}

module "categories" {
  source    = "./categories"
  parent_id = module.peer-votes_resources.resource_id
  args      = var.args
}

module "groups" {
  source    = "./groups"
  parent_id = module.peer-votes_resources.resource_id
  args      = var.args
}

module "me" {
  source    = "./me"
  parent_id = module.peer-votes_resources.resource_id
  args      = var.args
}

module "rankings" {
  source    = "./rankings"
  parent_id = module.peer-votes_resources.resource_id
  args      = var.args
}

module "validate" {
  source    = "./validate"
  parent_id = module.peer-votes_resources.resource_id
  args      = var.args
}


