module "ranking_id_resources" {
  source      = "app.terraform.io/hh-devops/api-gateway-modules/aws"
  version     = "1.0.0"
  rest_api_id = var.args.rest_api_id
  parent_id   = var.parent_id
  path_part   = "{ranking_id}"

  method_values = {
    GET = {
      authorization = var.args.authorization.CUSTOM
      authorizer_id = var.args.hwahae_authorizer_id_map.default
      method_request_parameters = {
        "method.request.path.ranking_id" = "true"
      }
      method_response_map = {
        200 = {
          response_models = var.args.response_models_empty
        }
      }
      integration_request_parameters = {
        "integration.request.path.ranking_id" = "method.request.path.ranking_id"
      }
      integration_uri = "http://$${stageVariables.HWAHAE_SERVER_API_ALB}/$${stageVariables.version}/rankings/{ranking_id}"
    }
  }
}

module "ad-product" {
  source    = "./ad-product"
  parent_id = module.ranking_id_resources.resource_id
  args      = var.args
}

module "details" {
  source    = "./details"
  parent_id = module.ranking_id_resources.resource_id
  args      = var.args
}

module "goods" {
  source    = "./goods"
  parent_id = module.ranking_id_resources.resource_id
  args      = var.args
}

module "products" {
  source    = "./products"
  parent_id = module.ranking_id_resources.resource_id
  args      = var.args
}
