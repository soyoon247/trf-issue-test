module "id_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{id}"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
      method_request_parameters = {
        "method.request.path.id" = "true"
      }
      method_response_map = {
        200 = {
          response_parameters = {
            "method.response.header.Access-Control-Allow-Origin" = "false"
          }
        }
        404 = {}
      }
      integration_request_parameters = {
        "integration.request.path.id" = "method.request.path.id"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/users/{id}"
    }
  }
}

module "address" {
  source    = "./address"
  parent_id = module.id_resources.resource_id
  args      = var.args
}

module "applies" {
  source    = "./applies"
  parent_id = module.id_resources.resource_id
  args      = var.args
}

module "baby" {
  source    = "./baby"
  parent_id = module.id_resources.resource_id
  args      = var.args
}

module "blocks" {
  source    = "./blocks"
  parent_id = module.id_resources.resource_id
  args      = var.args
}

module "cart-count" {
  source    = "./cart_count"
  parent_id = module.id_resources.resource_id
  args      = var.args
}

module "mypage" {
  source    = "./mypage"
  parent_id = module.id_resources.resource_id
  args      = var.args
}

module "point" {
  source    = "./point"
  parent_id = module.id_resources.resource_id
  args      = var.args
}

module "profile" {
  source    = "./profile"
  parent_id = module.id_resources.resource_id
  args      = var.args
}

module "push" {
  source    = "./push"
  parent_id = module.id_resources.resource_id
  args      = var.args
}

module "reviews" {
  source    = "./reviews"
  parent_id = module.id_resources.resource_id
  args      = var.args
}

module "review-reward-info" {
  source    = "./review-reward-info"
  parent_id = module.id_resources.resource_id
  args      = var.args
}

module "scrap" {
  source    = "./scrap"
  parent_id = module.id_resources.resource_id
  args      = var.args
}

module "subscribing" {
  source    = "./subscribing"
  parent_id = module.id_resources.resource_id
  args      = var.args
}

module "wishes" {
  source    = "./wishes"
  parent_id = module.id_resources.resource_id
  args      = var.args

}
