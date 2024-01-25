module "a_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "a"

  common_values = {
    authorization = var.args.authorization.CUSTOM
    authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer
  }

  method_values = {
    GET = {
      integration_uri = "https://jsonplaceholder.typicode.com/users/$${stageVariables.test_var}"
    }
    POST = {
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/products/util/compare3"
    }
  }
}

module "d" {
  source    = "./d"
  parent_id = module.a_resources.resource_id
  args      = var.args
}
