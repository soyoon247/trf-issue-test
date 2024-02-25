module "categories_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.6"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "categories"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.hwahae_authorizer

      method_request_parameters = {
        "method.request.querystring.depth"     = "false"
        "method.request.querystring.limit"     = "false"
        "method.request.querystring.offset"    = "false"
        "method.request.querystring.parent_id" = "false"
      }
      method_response_map = {
        200 = {}
        400 = {}
      }

      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/common/categories"
    }
  }
}

module "category_id" {
  source    = "./{category_id}"
  parent_id = module.categories_resources.resource_id
  args      = var.args
}


